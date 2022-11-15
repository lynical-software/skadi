import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/section.dart';

import '../widgets/example_scaffold.dart';

class ButtonsExample extends StatefulWidget {
  const ButtonsExample({Key? key}) : super(key: key);

  @override
  State<ButtonsExample> createState() => _ButtonsExampleState();
}

class _ButtonsExampleState extends State<ButtonsExample> with DeferDispose {
  var d = Debouncer();
  late ValueNotifier<bool> loadingNotifier =
      createDefer(() => ValueNotifier(false));
  String asyncButton = "SkadiAsyncButton";

  Future loading() async {
    loadingNotifier.value = true;
    await SkadiUtils.wait();
    loadingNotifier.value = false;
  }

  Future otherloading() async {
    await SkadiUtils.wait();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: 'Buttons Example',
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              asyncButton = "Longer SkadiAsyncButton";
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
      children: [
        Section(
          title: "SkadiAsyncIconButton",
          subtitle: "customizable icon button with loading",
          isRow: true,
          children: [
            SkadiAsyncIconButton(
              onTap: otherloading,
              icon: const Icon(Icons.notifications_active_outlined),
            ),
            SkadiAsyncIconButton(
              onTap: otherloading,
              backgroundColor: Colors.red[50],
              icon: const Icon(Icons.add, size: 32),
              loadingWidget: const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
            ),
            SkadiAsyncIconButton(
              onTap: otherloading,
              icon: const Text("Sign In"),
              padding: const EdgeInsets.all(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            SkadiAsyncIconButton(
              onTap: otherloading,
              icon: const Icon(Icons.notifications_active_outlined),
              borderSide: const BorderSide(color: Colors.purple),
            ),
          ],
        ),
        Section(
          title: "SkadiIconButton",
          subtitle: "customizable icon button",
          isRow: true,
          children: [
            SkadiIconButton(
              onTap: () {},
              icon: const Icon(Icons.notifications_active_outlined),
              borderSide: const BorderSide(color: Colors.purple),
            ),
            SkadiIconButton(
              onTap: () {},
              icon: const Icon(Icons.settings, color: Colors.white),
              backgroundColor: Colors.purple,
              borderRadius: 32,
              borderSide: const BorderSide(color: Colors.white),
              elevation: 2.0,
            ),
            SkadiIconButton(onTap: () {}, icon: const Text("Test")),
            SkadiIconButton(
              backgroundColor: Colors.blue[50],
              onTap: () {},
              icon: const Icon(CupertinoIcons.add),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        Section(
          title: "SkadiAsyncButton",
          subtitle: "buttons that support async and loading",
          isRow: false,
          children: [
            SkadiAsyncButton(
              fullWidth: false,
              onPressed: loading,
              child: Text(asyncButton),
            ),
            SkadiAsyncButton(
              fullWidth: false,
              startIcon: const Icon(Icons.edit),
              onPressed: otherloading,
              child: const Text("With icon"),
            ),
            [
              SkadiAsyncButton(
                fullWidth: false,
                width: 260,
                onPressed: otherloading,
                child: const Text("Custom width and height"),
              ),
              const SpaceX(),
              SkadiAsyncButton(
                fullWidth: false,
                width: 260,
                height: 46,
                onPressed: otherloading,
                child: const Text("Sign In"),
              ),
            ].wrapRow(),
            SkadiAsyncButton(
              fullWidth: true,
              onPressed: otherloading,
              loadingType: LoadingType.disable,
              loadingNotifier: loadingNotifier,
              disableColor: Colors.grey,
              child: const Text("Disable style and LoadingNotifier"),
            ),
          ],
        ),
      ],
    );
  }
}
