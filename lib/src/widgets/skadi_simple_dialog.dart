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
  final TextStyle? buttonTextStyle;

  ///A string to show in Dialog
  final String? content;

  ///
  final TextStyle? titleTextStyle;

  final bool _error;

  ///An alert dialog with title and content
  const SkadiSimpleDialog({
    Key? key,
    this.content,
    this.child,
    this.title = "Information",
    this.confirmText = "OK",
    this.onConfirm,
    this.buttonTextStyle,
    this.titleTextStyle,
  })  : _error = false,
        super(key: key);

  const SkadiSimpleDialog.error({
    Key? key,
    this.content,
    this.child,
    this.title = "Information",
    this.confirmText = "OK",
    this.onConfirm,
    this.buttonTextStyle,
    this.titleTextStyle,
  })  : _error = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiPlatformChecker(
      androidWidget: _buildAndroidDialog(context),
      iosWidget: _buildIOSDialog(context),
    );
  }

  Widget _buildIOSDialog(BuildContext context) {
    const errorStyle = TextStyle(
      fontSize: 17,
      color: CupertinoColors.systemRed,
      fontWeight: FontWeight.w600,
    );
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: titleTextStyle ?? (_error ? errorStyle : null),
      ),
      content: child ??
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(content ?? ""),
          ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDestructiveAction: _error,
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    return AlertDialog(
      shape: SkadiDecoration.roundRect(16),
      title: Text(title),
      titleTextStyle: titleTextStyle ??
          (_error
              ? Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: errorColor)
              : null),
      content: child ?? Text(content ?? ""),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: _error ? errorColor : null,
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
