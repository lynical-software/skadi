import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          ],
        ),
      ),
    );
  }
}
