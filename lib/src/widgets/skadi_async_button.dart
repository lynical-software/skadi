import 'package:flutter/material.dart';
import 'package:skadi/src/provider/skadi_provider.dart';

import '../utilities/types.dart';
import 'conditional_widget.dart';
import 'spacing.dart';

enum LoadingType { progress, disable }

///Create a Material Elevated Button that can contain a [loadingWidget] whenever you
///execute a Future function in [onPressed] callback
class SkadiAsyncButton extends StatefulWidget {
  ///A [child] to display inside the button
  final Widget child;

  ///onPressed callback
  final FutureOrCallBack? onPressed;

  ///Button's margin, default value is [vertical: 16]
  final EdgeInsets margin;

  ///[startIcon] will show on the left side of the button
  final Widget? startIcon;

  ///[endIcon] will show on the left side of the button
  final Widget? endIcon;

  ///A widget to show when button is loading
  final Widget? loadingWidget;

  ///Button's widget
  final double? width;

  ///Button's height
  final double? height;

  ///Button's background color
  final Color? backgroundColor;

  ///Button's text color
  final Color? foregroundColor;

  ///Button's disable layout color
  final Color? disableColor;

  ///A color for default [loadingWidget]
  final Color loadingColor;

  ///Button's shape
  final OutlinedBorder? shape;

  ///button's border side
  final BorderSide? borderSide;

  ///Button's elevation
  final double? elevation;

  ///Button padding
  final EdgeInsets padding;

  ///whether button is set to stretch with available width
  final bool fullWidth;

  /// select a loading type of the button
  final LoadingType loadingType;

  ///Alignment of the [icon] and [child]
  final MainAxisAlignment? alignment;

  ///Alignment of the [icon] and [child]
  final ValueNotifier<bool>? loadingNotifier;

  ///Create a Material Elevated Button that can contain a [loadingWidget] whenever you
  ///execute a Future function in [onPressed] callback
  const SkadiAsyncButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.fullWidth = true,
    this.loadingColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.loadingType = LoadingType.progress,
    this.startIcon,
    this.endIcon,
    this.loadingWidget,
    this.width,
    this.height,
    this.backgroundColor,
    this.shape,
    this.alignment,
    this.borderSide,
    this.foregroundColor,
    this.elevation,
    this.loadingNotifier,
    this.disableColor,
  }) : super(key: key);
  @override
  _SkadiAsyncButtonState createState() => _SkadiAsyncButtonState();
}

class _SkadiAsyncButtonState extends State<SkadiAsyncButton> {
  bool _isLoading = false;

  void onButtonPressed() async {
    if (_isLoading) return;
    try {
      _toggleLoading(true);
      await widget.onPressed?.call();
    } catch (exception) {
      rethrow;
    } finally {
      _toggleLoading(false);
    }
  }

  void _toggleLoading(bool value) {
    if (mounted) setState(() => _isLoading = value);
  }

  void _addListener() {
    if (widget.loadingNotifier != null) {
      _isLoading = widget.loadingNotifier!.value;
      widget.loadingNotifier!.addListener(_listener);
    }
  }

  void _removeListener() {
    if (widget.loadingNotifier != null) {
      widget.loadingNotifier!.addListener(_listener);
    }
  }

  void _listener() {
    bool value = widget.loadingNotifier!.value;
    _toggleLoading(value);
  }

  @override
  void initState() {
    _addListener();
    super.initState();
  }

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Check if this button has an icon. use to stretch the button if there is an icon
    final bool hasIcon = widget.startIcon != null || widget.endIcon != null;

    ///
    final Widget buttonContent = Row(
      mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: hasIcon ? MainAxisSize.max : MainAxisSize.min,
      children: [
        if (widget.startIcon != null) ...[
          widget.startIcon!,
          const SpaceX(),
        ],
        widget.child,
        if (widget.endIcon != null) ...[
          const SpaceX(),
          widget.endIcon!,
        ],
      ],
    );

    final Widget loadingWidget =
        widget.loadingWidget ?? SkadiProvider.of(context)?.buttonLoadingWidget ?? _buildLoadingWidget();

    return Container(
      height: widget.height,
      width: widget.fullWidth ? double.infinity : widget.width,
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: _isLoading
            ? widget.loadingType == LoadingType.disable
                ? null
                : () {}
            : widget.onPressed != null
                ? onButtonPressed
                : null,
        style: ElevatedButton.styleFrom(
          shape: widget.shape,
          padding: widget.padding,
          backgroundColor: widget.backgroundColor,
          disabledForegroundColor: widget.disableColor,
          foregroundColor: widget.foregroundColor,
          side: widget.borderSide,
          elevation: widget.elevation,
        ),
        child: ConditionalWidget(
          condition: _isLoading,
          onTrue: () => widget.loadingType == LoadingType.disable ? buttonContent : loadingWidget,
          onFalse: () => buttonContent,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: widget.startIcon != null ? 24 : 20,
      height: widget.startIcon != null ? 24 : 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.loadingColor),
      ),
    );
  }
}
