import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class ControlExample extends StatefulWidget {
  const ControlExample({Key? key}) : super(key: key);

  @override
  State<ControlExample> createState() => _ControlExampleState();
}

class _ControlExampleState extends State<ControlExample> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isLoading = LoadingOverlayProvider.instance.isLoading;
        if (isLoading) {
          LoadingOverlayProvider.switchPosition(LoadingOverlayPosition.below);
          bool? result = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const SkadiConfirmationDialog.danger(
              content: Text("Are you sure you want to cancel this operation?"),
              confirmText: "Yes",
              cancelText: "Discard",
            ),
          );
          if (result == true) {
            ///Cancel your operation
            LoadingOverlayProvider.toggle(false);
          }
          LoadingOverlayProvider.switchPosition(LoadingOverlayPosition.above);
          return false;
        }
        return true;
      },
      child: ExampleScaffold(
        title: "Control",
        children: [
          Section(
            title: "SkadiAccordion",
            isRow: false,
            children: [
              ValueNotifierWrapper<bool>(
                initialValue: false,
                builder: (notifier, value, child) {
                  return SkadiAccordion(
                    title: const Text("Click me to expand"),
                    onToggle: (value) {
                      notifier.value = value;
                    },
                    value: value,
                    children: List.generate(
                      3,
                      (index) => ListTile(
                        title: Text("I'm a children $index"),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Section(
            title: "LoadingOverlay",
            subtitle:
                "Must create LoadingOverlayProvider.builder above MaterialApp or MaterialApp builder for this to work",
            isRow: false,
            children: [
              ElevatedButton(
                onPressed: () async {
                  LoadingOverlayProvider.toggle();
                  await SkadiUtils.wait(10000);
                  LoadingOverlayProvider.toggle(false);
                },
                child: const Text("Click"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
