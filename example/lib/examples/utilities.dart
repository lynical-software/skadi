import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class UtilitiesMethodUsage extends StatefulWidget {
  const UtilitiesMethodUsage({Key? key}) : super(key: key);

  @override
  State<UtilitiesMethodUsage> createState() => _UtilitiesMethodUsageState();
}

class _UtilitiesMethodUsageState extends State<UtilitiesMethodUsage> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: "Utilities Method Usage",
      children: [
        Image.network(
          SkadiUtils.unsplashImage(category: "dogs"),
        ),
        Section(
          title: "Logger",
          isRow: false,
          children: [
            ElevatedButton(
              onPressed: () {
                errorLog("use to log eror");
                httpLog("use to log something relate to http");
                infoLog("use to log other things");
              },
              child: const Text("Show logs"),
            ),
          ],
        ),
        Section(
          title: "Others",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () async {
                infoLog("Has internet connection?",
                    await SkadiUtils.checkConnection());
              },
              child: const Text("Check connection"),
            ),
          ],
        ),
      ],
    );
  }
}
