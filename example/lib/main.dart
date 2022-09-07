import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/examples/buttons.dart';
import 'package:skadi_example/examples/style_decoraction.dart';

import 'examples/dialogs.dart';
import 'examples/mixin.dart';
import 'examples/other_widget.dart';
import 'examples/utilities.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkadiProvider(
      loadingWidget: const Text("loading..."),
      noDataWidget: const Text("No data :("),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          SkadiRouteObserver(log: true),
        ],
        title: 'Skadi Flutter Example',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.comfortable,
        ),
        home: const RootPage(),
        builder: (context, child) {
          return LoadingOverlayProvider.builder(
            child: SkadiResponsiveBuilder(builder: (_) => child!),
          );
        },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final examples = <ExampleButton>[
    ExampleButton(name: "Buttons", child: const ButtonsExample()),
    ExampleButton(name: "Dialogs", child: const DialogsExample()),
    ExampleButton(name: "Mixin Example", child: const MixinExample()),
    ExampleButton(
        name: "Style and Decoration", child: const StyleAndDecorationExample()),
    ExampleButton(name: "Other widgets", child: const OtherWidgetExample()),
    ExampleButton(
        name: "Utilities Method Usage", child: const UtilitiesMethodUsage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skadi Example")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        children: [
          for (var widget in examples)
            ElevatedButton(
              onPressed: () {
                SkadiNavigator.push(context, widget.child);
              },
              child: Text(widget.name),
            ),
        ],
      ),
    );
  }
}

class ExampleButton {
  final String name;
  final Widget child;

  ExampleButton({required this.name, required this.child});
}
