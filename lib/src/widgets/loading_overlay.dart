import 'package:flutter/material.dart';

import '../../skadi.dart';

class LoadingOverlayProvider {
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  LoadingOverlayProvider._();
  static LoadingOverlayProvider instance = LoadingOverlayProvider._();

  static Widget builder({Key? key, required Widget child, Widget? loadingWidget}) {
    return _LoadingOverlayBuilder(
      loadingWidget: loadingWidget,
      child: child,
    );
  }

  bool get isLoading => _loadingNotifier.value;

  static void toggle([bool? value]) {
    LoadingOverlayProvider.instance._toggleLoading(value);
  }

  void _toggleLoading([bool? value]) {
    final bool isLoading = value ?? !_loadingNotifier.value;
    _loadingNotifier.value = isLoading;
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
    final color = Theme.of(context).brightness == Brightness.dark ? Colors.grey.withOpacity(0.2) : Colors.black26;
    return Stack(
      children: [
        child,
        ValueListenableBuilder<bool>(
          valueListenable: LoadingOverlayProvider.instance._loadingNotifier,
          child: loadingWidget ??
              Container(
                color: color,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
          builder: (context, isLoading, child) {
            if (isLoading) {
              return child!;
            }
            return emptySizedBox;
          },
        ),
      ],
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
