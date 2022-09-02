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
  late ValueNotifier<bool> loadingNotifier = createDefer(() => ValueNotifier(false));

  Future loading() async {
    loadingNotifier.value = true;
    await SkadiUtils.wait();
    loadingNotifier.value = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: 'Buttons Example',
      children: [
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
          ],
        ),
        Section(
          title: "Buttons with Loading",
          subtitle: "buttons that support async and loading",
          isRow: false,
          children: [
            SkadiAsyncButton(
              fullWidth: true,
              onPressed: loading,
              child: const Text("SkadiAsyncButton"),
            ),
            SkadiAsyncButton(
              fullWidth: true,
              onPressed: loading,
              loadingType: LoadingType.disable,
              child: const Text("SkadiAsyncButton disable style"),
            ),
            SkadiAsyncIconButton(
              onTap: loading,
              icon: const Icon(Icons.add, color: Colors.blue),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            SkadiLoadingButton(
              fullWidth: false,
              loadingNotifier: loadingNotifier,
              onPressed: loading,
              child: const Text("SkadiLoadingButton"),
            ),
          ],
        ),
      ],
    );
  }
}
