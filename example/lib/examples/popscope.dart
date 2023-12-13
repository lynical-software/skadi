import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class PopScopeExample extends StatefulWidget {
  const PopScopeExample({super.key});

  @override
  State<PopScopeExample> createState() => _PopScopeExampleState();
}

class _PopScopeExampleState extends State<PopScopeExample> {
  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return WillPopPrompt(
      child: ExampleScaffold(
        title: "PopScope",
        children: [
          Section(
            title: "Disable",
            isRow: true,
            children: [
              ElevatedButton(
                onPressed: () {
                  LoadingOverlayProvider.toggle();
                },
                child: const Text("Can Pop"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
