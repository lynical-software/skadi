// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';
import 'conditional_widget.dart';
import 'spacing.dart';

class SkadiLoadingButton extends StatelessWidget {
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
  final Color? color;

  ///Text's color for a child that usually a Text
  final Color? textColor;

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

  ///
  final GlobalKey _globalKey = GlobalKey();

  ///Create a button with loading notifier
  SkadiLoadingButton({
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
    this.color,
    this.textColor,
    this.icon,
    this.onLongPressed,
    this.alignment,
    this.borderSide,
  }) : super(key: key);

  void maintainWidthOnLoading() {
    if (fullWidth == false && width == null) {
      WidgetsBinding.instance.addPostFrameCallback((d) {
        if (_globalKey.currentContext != null) {
          RenderBox box =
              _globalKey.currentContext!.findRenderObject() as RenderBox;
          width = box.size.width;
        }
      });
    }
  }

  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      color: Colors.transparent,
      margin: margin,
      child: ValueListenableBuilder<bool>(
        valueListenable: loadingNotifier ?? ValueNotifier(false),
        builder: (context, loading, _) {
          maintainWidthOnLoading();
          return ElevatedButton(
            onPressed: loading ? () {} : onPressed,
            style: ElevatedButton.styleFrom(
              shape: shape,
              primary: color,
              onPrimary: textColor,
              padding: padding,
              elevation: elevation,
              side: borderSide,
            ),
            onLongPress: loading ? () {} : () => onLongPressed?.call(),
            child: ConditionalWidget(
              condition: loading,
              onFalse: () => Row(
                key: _globalKey,
                mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (icon != null) ...[
                    icon ?? emptySizedBox,
                    const SpaceX(8),
                  ],
                  child,
                ],
              ),
              onTrue: () =>
                  loadingWidget ??
                  SkadiProvider.of(context)?.buttonLoadingWidget ??
                  _buildLoadingWidget(),
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
          width: icon != null ? 24 : 20,
          height: icon != null ? 24 : 20,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
          ),
        ),
      ),
    );
  }
}
