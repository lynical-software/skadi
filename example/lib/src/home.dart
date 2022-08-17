import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/src/navigator_pages.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SkadiAsyncIconButton(
            onTap: () async {
              await SkadiUtils.wait(2000);
            },
            margin: const EdgeInsets.all(8),
            icon: const Icon(Icons.notifications),
            badge: const Text("2"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return SkadiConfirmationDialog.danger(
                      confirmText: "Delete",
                      content: const Text("Delete account?"),
                      onCancel: () {
                        print("cancel");
                      },
                      onConfirm: () {
                        print("delete");
                      },
                    );
                  },
                );
              },
              child: const Text("Show confirmation"),
            ),
            ElevatedButton(
              onPressed: () {
                SkadiNavigator.push(context, const Detail1());
              },
              child: const Text("Detail"),
            ),
            ElevatedButton(
              onPressed: () {
                SkadiRouteObserver.showRoutes();
              },
              child: const Text("Show history"),
            ),
            SkadiAsyncIconButton(
              onTap: () async {
                await SkadiUtils.wait(2000);
              },
              margin: const EdgeInsets.all(8),
              icon: const Icon(Icons.notifications),
              badge: const Text("2"),
              borderSide: const BorderSide(),
            ),
          ],
        ),
      ),
    );
  }
}
