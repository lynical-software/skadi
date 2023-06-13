import 'package:flutter/material.dart';

class ExampleScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final List<Widget>? actions;
  const ExampleScaffold({
    Key? key,
    required this.title,
    required this.children,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: children,
      ),
    );
  }
}
