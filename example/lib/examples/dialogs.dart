import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class DialogsExample extends StatefulWidget {
  const DialogsExample({Key? key}) : super(key: key);

  @override
  State<DialogsExample> createState() => _DialogsExampleState();
}

class _DialogsExampleState extends State<DialogsExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: "Dialogs",
      children: [
        Section(
          title: "SkadiConfirmationDialog",
          subtitle: "show adaptive dialog with 2 actions",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SkadiConfirmationDialog(
                    content: const Text("Confirm this action?"),
                    onConfirm: () {
                      infoLog("you confirm");
                    },
                    onCancel: () {
                      infoLog("you cancel");
                    },
                  ),
                );
              },
              child: const Text("show"),
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => SkadiConfirmationDialog.danger(
                      title: "Danger action",
                      confirmText: "Delete",
                      content: const Text("You want to delete?"),
                      onConfirm: () {
                        infoLog("you confirm");
                      },
                      onCancel: () {
                        infoLog("you cancel");
                      },
                    ),
                  );
                },
                child: const Text("show danger")),
          ],
        ),
        Section(
          title: "Others",
          isRow: false,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SkadiSimpleDialog(
                    title: "Simple",
                    content: "Simple dialog content",
                  ),
                );
              },
              child: const Text("Show simple dialog"),
            ),
            ElevatedButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => SkadiActionSheet<String>(
                    title: "Your favorite animal",
                    options: const ["Dog", "Cat"],
                    builder: (option, index) => Text(option),
                    onSelected: (option, index) {
                      showDialog(
                        context: context,
                        builder: (context) => SkadiSimpleDialog(
                          title: "Your choice",
                          content: "You chose: $option",
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Text("Show Skadi action sheet"),
            ),
          ],
        ),
      ],
    );
  }
}
