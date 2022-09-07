import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class StyleAndDecorationExample extends StatefulWidget {
  const StyleAndDecorationExample({Key? key}) : super(key: key);

  @override
  State<StyleAndDecorationExample> createState() =>
      _StyleAndDecorationExampleState();
}

class _StyleAndDecorationExampleState extends State<StyleAndDecorationExample> {
  @override
  Widget build(BuildContext context) {
    return const ExampleScaffold(
      title: "Style and Decoration example",
      children: [
        Section(
          title: "ShadowInputBorder",
          isRow: false,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Username",
                errorText:
                    "use this instead of other method to show error text correctly",
                errorStyle: TextStyle(fontSize: 10),
                border: ShadowInputBorder(
                  elevation: 2.0,
                  fillColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
