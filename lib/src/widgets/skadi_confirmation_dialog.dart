import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/types.dart';
import 'skadi_platform_checker.dart';

///Create a dialog that provide onCancel and Confirm action
class SkadiConfirmationDialog extends StatelessWidget {
  final Widget content;
  final String title;
  final String cancelText;
  final String confirmText;
  final FutureOrCallBack? onCancel;
  final FutureOrCallBack? onConfirm;
  //
  final ShapeBorder? androidDialogShape;
  final Color? confirmTextColor;
  final Color? cancelTextColor;

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
    this.confirmTextColor,
    this.cancelTextColor,
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
    this.confirmTextColor,
    this.cancelTextColor,
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
    final List<Widget> actions = <Widget>[
      CupertinoDialogAction(
        isDestructiveAction: !_danger,
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
        isDestructiveAction: _danger,
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
    final dangerStyle = TextButton.styleFrom(foregroundColor: Colors.red);
    final List<Widget> actions = <Widget>[
      TextButton(
        style: !_danger ? dangerStyle : null,
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
        style: _danger ? dangerStyle : null,
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
