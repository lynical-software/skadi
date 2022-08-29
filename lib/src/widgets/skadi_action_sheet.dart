import 'package:flutter/cupertino.dart';

///A cupertino action sheet that use to create an option selector
class SkadiActionSheet<T> extends StatelessWidget {
  ///When you tap on [options], it will return it's index value as a result
  final List<T> options;

  ///A text that show above all the options
  final String title;

  ///A text that show at the bottom of options
  final String cancelText;

  ///A function that call after you selected one of the options
  final void Function(T option, int index)? onSelected;

  ///A widget builder of option
  final Widget Function(T option, int index) builder;

  ///A cupertino action sheet that use to create an option selector
  const SkadiActionSheet({
    Key? key,
    required this.builder,
    required this.title,
    required this.options,
    this.cancelText = "Cancel",
    this.onSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      message: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      actions: List.generate(options.length, (index) {
        final T option = options[index];
        return CupertinoActionSheetAction(
          child: builder.call(option, index),
          onPressed: () {
            Navigator.pop(context, index);
            onSelected?.call(option, index);
          },
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, -1);
        },
        child: Text(cancelText),
      ),
    );
  }
}
