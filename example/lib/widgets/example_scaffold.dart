import 'package:flutter/material.dart';

class ExampleScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ExampleScaffold({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: children,
      ),
    );
  }
}
