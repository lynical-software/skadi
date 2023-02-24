import 'package:flutter/material.dart';

enum LoadingOverlayPosition {
  above,
  below,
}

class LoadingOverlayProvider extends ChangeNotifier {
  bool _loadingNotifier = false;
  LoadingOverlayPosition _overlayPosition = LoadingOverlayPosition.above;

  //
  LoadingOverlayProvider._();
  static LoadingOverlayProvider instance = LoadingOverlayProvider._();

  static Widget builder(
      {Key? key, required Widget child, Widget? loadingWidget}) {
    return _LoadingOverlayBuilder(
      loadingWidget: loadingWidget,
      child: child,
    );
  }

  bool get isLoading => _loadingNotifier;
  LoadingOverlayPosition get position => _overlayPosition;

  ///Toggle the loading overlay
  static void toggle([bool? value]) {
    LoadingOverlayProvider.instance._toggleLoading(value);
  }

  ///Bring loading overlay below our current widget
  ///useful when you want to show dialog while loading
  static void switchPosition(LoadingOverlayPosition position) {
    LoadingOverlayProvider.instance._switchPosition(position);
  }

  void _toggleLoading([bool? value]) {
    final bool isLoading = value ?? !_loadingNotifier;
    _loadingNotifier = isLoading;
    notifyListeners();
  }

  void _switchPosition(LoadingOverlayPosition position) {
    _overlayPosition = position;
    notifyListeners();
  }
}

class _LoadingOverlayBuilder extends StatelessWidget {
  final Widget child;

  ///A custom loading overlay widget.
  ///Default value is CircularProgressIndicator with Grey.02 background
  final Widget? loadingWidget;

  ///Create an LoadingOverlayProvider within this app
  const _LoadingOverlayBuilder({
    Key? key,
    required this.child,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.withOpacity(0.2)
        : Colors.black26;
    final instance = LoadingOverlayProvider.instance;
    final loadingContent = loadingWidget ??
        Container(
          color: color,
          child: const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        );
    return AnimatedBuilder(
      animation: instance,
      builder: (context, child) {
        final bool isLoading = instance.isLoading;
        return Stack(
          children: [
            if (instance._overlayPosition == LoadingOverlayPosition.above) ...[
              child!,
              if (isLoading) loadingContent,
            ] else ...[
              if (isLoading) loadingContent,
              child!,
            ],
          ],
        );
      },
      child: child,
    );
  }
}

class LoadingOverlayPopScope extends StatefulWidget {
  final Widget child;

  ///If [allowPop] is true, when user pressed back button
  ///LoadingOverlay will be dismiss and screen will be pop like normal
  final bool allowPop;

  ///Wrap this above your widget to prevent user from pop with screen LoadingOverlayProvider is loading
  ///This only happen in Android since iOS device doesn't have back button
  const LoadingOverlayPopScope({
    Key? key,
    required this.child,
    this.allowPop = false,
  }) : super(key: key);

  @override
  State<LoadingOverlayPopScope> createState() => _LoadingOverlayPopScopeState();
}

class _LoadingOverlayPopScopeState extends State<LoadingOverlayPopScope> {
  void onDismissIfAllow() {
    if (widget.allowPop) {
      LoadingOverlayProvider.toggle(false);
    }
  }

  @override
  void dispose() {
    Future.microtask(() => onDismissIfAllow());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: widget.child,
      onWillPop: () async {
        final bool isLoading = LoadingOverlayProvider.instance.isLoading;
        if (!isLoading) return true;
        return widget.allowPop ? true : !isLoading;
      },
    );
  }
}
