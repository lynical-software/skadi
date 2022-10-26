import 'dart:math';

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
                    positiveTextStyle: const TextStyle(color: Colors.blue),
                    content: const Text("Confirm this action?"),
                    onConfirm: () {
                      infoLog("you confirm");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      infoLog("you cancel");
                      Navigator.pop(context);
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
                    positiveTextStyle: const TextStyle(color: Colors.blue),
                    title: "Danger action",
                    confirmText: "Delete",
                    content: const Text("You want to delete?"),
                    onConfirm: () async {
                      var nav = Navigator.of(context);
                      LoadingOverlayProvider.toggle();
                      infoLog("you confirm");
                      await SkadiUtils.wait(1000);
                      bool success = Random().nextBool();
                      LoadingOverlayProvider.toggle();
                      if (success) {
                        nav.pop();
                      }
                    },
                    onCancel: () {
                      infoLog("you cancel");
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Text("show danger"),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SkadiConfirmationDialog(
                    positiveTextStyle: const TextStyle(color: Colors.blue),
                    content: const Text("ចុម? លេងអីតាណើបៗចឹង?"),
                    title: "កាងម៉េស",
                    confirmText: "អញចឹង",
                    cancelText: "សូមទោសបង",
                    onConfirm: () {
                      infoLog("you confirm");
                      Navigator.pop(context);
                    },
                    onCancel: () {
                      infoLog("you cancel");
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Text("ពុម្ពអក្សរខ្មែរ"),
            ),
          ],
        ),
        Section(
          title: "SkadiSimpleDialog",
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
          ],
        ),
        Section(
          title: "SkadiActionSheet",
          isRow: false,
          children: [
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
