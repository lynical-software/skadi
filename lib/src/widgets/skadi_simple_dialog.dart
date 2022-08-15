import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiSimpleDialog extends StatelessWidget {
  ///Dialog title
  final String title;

  ///Action button text, default is "OK"
  final String confirmText;

  ///A function that run before you pressed on confirm button
  final VoidCallback? onConfirm;

  ///If child is provided, [content] will be ignore
  final Widget? child;

  ///Confirm button color
  final Color? buttonColor;

  ///A string to show in Dialog
  final String content;

  ///An alert dialog with title and content
  const SkadiSimpleDialog({
    Key? key,
    required this.content,
    this.child,
    this.title = "Information",
    this.confirmText = "OK",
    this.onConfirm,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiPlatformChecker(
      androidWidget: _buildAndroidDialog(context),
      iosWidget: _buildIOSDialog(context),
    );
  }

  Widget _buildIOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: child ??
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(content),
          ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(confirmText),
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  Widget _buildAndroidDialog(BuildContext context) {
    return AlertDialog(
      shape: SkadiDecoration.roundRect(16),
      title: Text(title),
      content: child ?? Text(content),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            primary: buttonColor,
          ),
          child: Text(confirmText),
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
