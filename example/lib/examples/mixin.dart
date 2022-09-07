import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';

class Cat extends ChangeNotifier {}

class MixinExample extends StatefulWidget {
  const MixinExample({Key? key}) : super(key: key);

  @override
  State<MixinExample> createState() => _MixinExampleState();
}

class _MixinExampleState extends State<MixinExample>
    with AfterBuildMixin, SkadiFormMixin, BoolNotifierMixin, DeferDispose {
  ///
  ///Create an auto dispose ChangeNotifier
  late ValueNotifier<bool> notifier = createDefer(() => ValueNotifier(true));
  late FutureManager<int> manager = createDefer(() => FutureManager());
  late Cat cat = createDefer(() => Cat());

  ///
  @override
  void afterBuild(BuildContext context) {
    infoLog("This method call after widget has been built");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Using SkadiFormMixin
    return KeyboardDismiss(
      child: Form(
        key: formKey,
        child: ExampleScaffold(
          title: "Mixin Example",
          children: [
            TextFormField(
              validator: (value) => SkadiFormValidator.validateEmail(value),
              decoration: const InputDecoration(
                hintText: "email",
                border: ShadowInputBorder(elevation: 2.0, fillColor: Colors.white),
              ),
            ),
            cat.builder(builder: ((context, child) => emptySizedBox)),
            manager.builder(builder: ((context, child) => emptySizedBox)),

            ///Using BoolNotifier mixin
            boolNotifier.builder(
              builder: (context, child) {
                return SwitchListTile(
                  title: const Text("Remember me"),
                  value: boolNotifier.value,
                  onChanged: toggleValue,
                );
              },
            ),
            SkadiLoadingButton(
              loadingNotifier: notifier,
              shape: SkadiDecoration.roundRect(),
              onPressed: () {
                if (isFormValidated) {}
              },
              child: const Text("Validate"),
            ),
          ],
        ),
      ),
    );
  }
}
