import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';
import 'conditional_widget.dart';
import 'spacing.dart';

class SkadiLoadingButton extends StatefulWidget {
  ///receive a ValueNotifier to indicate a loading widget
  final ValueNotifier<bool>? loadingNotifier;

  ///
  final Widget child;

  ///An icon to show at before [child]
  final Widget? icon;

  ///
  final VoidCallback? onPressed;

  ///
  final Function? onLongPressed;

  //
  final double? elevation;

  ///Button's background Color
  final Color? primary;

  ///Text's color for a child that usually a Text
  final Color? onPrimary;

  ///Button's disable layout color
  final Color? onSurface;

  ///Loading indicator's color, default is [white]
  final Color loadingColor;

  ///A widget to show when loading, if the value is null,
  ///it will use a loading widget from SkadiProvider or CircularProgressIndicator
  final Widget? loadingWidget;

  ///Button's margin
  final EdgeInsets margin;

  ///Button's padding
  final EdgeInsets padding;

  ///Button's shape, default is [StadiumBorder]
  final OutlinedBorder? shape;

  ///child's alignment
  final MainAxisAlignment? alignment;

  ///if [fullWidth] is `true`, Button will take all remaining horizontal space
  final bool fullWidth;

  ///
  final BorderSide? borderSide;

  ///Create a button with loading notifier
  const SkadiLoadingButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.loadingColor = Colors.white,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.fullWidth = false,
    this.shape = const StadiumBorder(),
    this.elevation = 2.0,
    this.loadingNotifier,
    this.loadingWidget,
    this.primary,
    this.onPrimary,
    this.icon,
    this.onLongPressed,
    this.alignment,
    this.borderSide,
    this.onSurface,
  }) : super(key: key);

  @override
  State<SkadiLoadingButton> createState() => _SkadiLoadingButtonState();
}

class _SkadiLoadingButtonState extends State<SkadiLoadingButton> {
  ///
  final GlobalKey _globalKey = GlobalKey();
  double? width;

  void maintainWidthOnLoading() {
    if (widget.fullWidth == false && width == null) {
      WidgetsBinding.instance.addPostFrameCallback((d) {
        if (_globalKey.currentContext != null) {
          RenderBox box = _globalKey.currentContext!.findRenderObject() as RenderBox;
          width = box.size.width;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fullWidth ? double.infinity : null,
      color: Colors.transparent,
      margin: widget.margin,
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.loadingNotifier ?? ValueNotifier(false),
        builder: (context, loading, _) {
          maintainWidthOnLoading();
          return ElevatedButton(
            onPressed: loading ? () {} : widget.onPressed,
            style: ElevatedButton.styleFrom(
              shape: widget.shape,
              primary: widget.primary,
              onSurface: widget.onSurface,
              onPrimary: widget.onPrimary,
              padding: widget.padding,
              elevation: widget.elevation,
              side: widget.borderSide,
            ),
            onLongPress: loading ? () {} : () => widget.onLongPressed?.call(),
            child: ConditionalWidget(
              condition: loading,
              onFalse: () => Row(
                key: _globalKey,
                mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (widget.icon != null) ...[
                    widget.icon ?? emptySizedBox,
                    const SpaceX(8),
                  ],
                  widget.child,
                ],
              ),
              onTrue: () =>
                  widget.loadingWidget ?? SkadiProvider.of(context)?.buttonLoadingWidget ?? _buildLoadingWidget(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: width,
      child: Center(
        child: SizedBox(
          width: widget.icon != null ? 24 : 20,
          height: widget.icon != null ? 24 : 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(widget.loadingColor),
          ),
        ),
      ),
    );
  }
}
