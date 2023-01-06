import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/examples/buttons.dart';
import 'package:skadi_example/examples/controls.dart';
import 'package:skadi_example/examples/navigator.dart';
import 'package:skadi_example/examples/style_decoration.dart';

import 'examples/dialogs.dart';
import 'examples/mixin.dart';
import 'examples/other_widget.dart';
import 'examples/utilities.dart';
import 'widgets/custom_overlay_loading.dart';

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
      logSetting: const SkadiLogSetting(
        http: true,
        info: true,
        error: true,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          SkadiRouteObserver(
            log: true,
            analyticCallBack: (route) {},
          ),
        ],
        title: 'Skadi Flutter Example',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
          ),
          fontFamily: GoogleFonts.kantumruy().fontFamily,
        ),
        home: const RootPage(),
        builder: (context, child) {
          return LoadingOverlayProvider.builder(
            child: SkadiResponsiveBuilder(builder: (_) => child!),
            loadingWidget: const CustomLoadingOverlay(),
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
    ExampleButton(name: "Controls", child: const ControlExample()),
    ExampleButton(name: "Dialogs", child: const DialogsExample()),
    ExampleButton(
      name: "Mixin Example",
      child: const MixinExample(),
    ),
    ExampleButton(
      name: "Navigator Example",
      child: const SkadiNavigatorExample(),
    ),
    ExampleButton(name: "Other widgets", child: const OtherWidgetExample()),
    ExampleButton(
      name: "Style and Decoration",
      child: const StyleAndDecorationExample(),
    ),
    ExampleButton(
      name: "Utilities Method Usage",
      child: const UtilitiesMethodUsage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Skadi Example")),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: SkadiResponsive.auto(16),
        ),
        children: [
          for (var widget in examples)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  await SkadiNavigator.push(context, widget.child);
                  SkadiUtils.wait().then((value) {
                    infoLog("Manager", manager);
                  });
                },
                child: Text(widget.name),
              ),
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
