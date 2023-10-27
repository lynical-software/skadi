import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiAsyncIconButton extends StatefulWidget {
  ///
  final FutureOrCallBack? onTap;

  ///
  final Widget icon;

  ///
  final EdgeInsets margin;

  ///
  final EdgeInsets padding;

  ///
  final Color? backgroundColor;

  ///
  final Color? loadingColor;

  ///Button's borderRadius, You can check [borderRadius] documentation on Flutter
  final double borderRadius;

  ///Button's elevation, You can check [elevation] documentation on Flutter
  final double elevation;

  ///Border side of the button, You can check [borderSide] documentation on Flutter
  final BorderSide? borderSide;

  ///Small badge shown similar to Notification badge
  final Widget? badge;

  ///A widget to show when button is loading
  ///Using LoadingWidget from SkadiProvider or default CircularProgressIndicator with 24px
  final Widget? loadingWidget;

  ///
  final double? width;

  ///Minimum icon button size
  final Size? size;

  ///An IconButton with respectively small margin and shape
  const SkadiAsyncIconButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.backgroundColor,
    this.elevation = 0.0,
    this.borderSide,
    this.badge,
    this.loadingWidget,
    this.loadingColor,
    this.width,
    this.size,
  }) : super(key: key);

  @override
  State<SkadiAsyncIconButton> createState() => _SkadiAsyncIconButtonState();
}

class _SkadiAsyncIconButtonState extends State<SkadiAsyncIconButton> {
  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      side: widget.borderSide ?? BorderSide.none,
    );

    final Widget? providedLoadingWidget =
        widget.loadingWidget ?? SkadiProvider.of(context)?.buttonLoadingWidget;

    return Stack(
      children: [
        SkadiAsyncButton(
          onPressed: widget.onTap,
          fullWidth: false,
          width: widget.width,
          style: TextButton.styleFrom(
            shape: shape,
            elevation: widget.elevation,
            padding: widget.padding,
            minimumSize: widget.size ?? const Size(40, 40),
            backgroundColor: widget.backgroundColor ?? Colors.transparent,
          ),
          margin: widget.margin,
          loadingColor: widget.loadingColor ?? context.primaryColor,
          loadingWidget: providedLoadingWidget,
          child: widget.icon,
        ),
        if (widget.badge != null)
          Positioned(
            top: 0,
            right: 0,
            child: widget.badge!,
          ),
      ],
    );
  }
}
