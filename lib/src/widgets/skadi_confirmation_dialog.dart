import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/types.dart';
import 'skadi_platform_checker.dart';

///Create a dialog that provide onCancel and Confirm action
class SkadiConfirmationDialog extends StatelessWidget {
  ///Dialog content, has a default 12 padding top
  final Widget content;

  ///Dialog title
  final String title;

  ///
  final String cancelText;

  ///
  final String confirmText;

  ///Confirm callback, If this param isn't null, you have to manually pop the dialog
  final FutureOrCallBack? onCancel;

  ///Confirm callback, If this param isn't null, you have to manually pop the dialog
  final FutureOrCallBack? onConfirm;

  ///Custom shape for Android dialog
  final ShapeBorder? androidDialogShape;

  ///Custom style for a positive action, because sometime primary color of the app can be [Red] that
  ///can make a confusion for user
  ///This apply to [confirmText] in default dialog
  ///This apply to [cancelText] in danger dialog
  final TextStyle? positiveTextStyle;

  ///Mark confirm action as a danger action
  final bool _danger;

  ///A dialog that provide onCancel and Confirm action
  const SkadiConfirmationDialog({
    Key? key,
    required this.content,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.title = "Confirmation",
    this.onCancel,
    this.onConfirm,
    this.androidDialogShape,
    this.positiveTextStyle,
  })  : _danger = false,
        super(key: key);

  const SkadiConfirmationDialog.danger({
    Key? key,
    required this.content,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
    this.title = "Confirmation",
    this.onCancel,
    this.onConfirm,
    this.androidDialogShape,
    this.positiveTextStyle,
  })  : _danger = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiPlatformChecker(
      androidWidget: _buildAndroidDialog(context),
      iosWidget: _buildIOSDialog(context),
    );
  }

  Widget _buildIOSDialog(BuildContext context) {
    const dangerStyle = TextStyle(color: Colors.red);
    final List<Widget> actions = <Widget>[
      CupertinoDialogAction(
        textStyle: !_danger ? dangerStyle : positiveTextStyle,
        onPressed: () {
          if (onCancel != null) {
            onCancel!.call();
          } else {
            Navigator.pop(context, false);
          }
        },
        child: Text(cancelText),
      ),
      CupertinoDialogAction(
        textStyle: _danger ? dangerStyle : positiveTextStyle,
        onPressed: () {
          if (onConfirm != null) {
            onConfirm!.call();
          } else {
            Navigator.pop(context, true);
          }
        },
        child: Text(confirmText),
      ),
    ];

    return CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: content,
      ),
      actions: actions,
    );
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final dangerStyle = TextButton.styleFrom(
      foregroundColor: Colors.red,
    );
    final confirmStyle = TextButton.styleFrom(
      foregroundColor: positiveTextStyle?.color,
      textStyle: positiveTextStyle,
    );
    final List<Widget> actions = <Widget>[
      TextButton(
        style: !_danger ? dangerStyle : confirmStyle,
        onPressed: () {
          if (onCancel != null) {
            onCancel!.call();
          } else {
            Navigator.pop(context, false);
          }
        },
        child: Text(cancelText),
      ),
      TextButton(
        style: _danger ? dangerStyle : confirmStyle,
        onPressed: () {
          if (onConfirm != null) {
            onConfirm!.call();
          } else {
            Navigator.pop(context, true);
          }
        },
        child: Text(confirmText),
      ),
    ];
    return AlertDialog(
      shape: androidDialogShape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}
