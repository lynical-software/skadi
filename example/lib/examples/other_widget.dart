import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class OtherWidgetExample extends StatefulWidget {
  const OtherWidgetExample({Key? key}) : super(key: key);

  @override
  State<OtherWidgetExample> createState() => _OtherWidgetExampleState();
}

class _OtherWidgetExampleState extends State<OtherWidgetExample> {
  String? nullableString = "I can be null" * 20;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: ExampleScaffold(
        title: "Other widgets",
        children: [
          Section(
            title: "EllipsisText",
            subtitle: "nullable Text with ellipsis",
            isRow: false,
            children: [
              EllipsisText(nullableString),
            ],
          ),
          const SpaceX(),
          const Section(
            title: "SkadiPlatformChecker",
            subtitle: "adaptive platform widget",
            isRow: false,
            children: [
              SkadiPlatformChecker(
                androidWidget: TextField(
                  decoration:
                      InputDecoration(hintText: "Android Material textfield"),
                ),
                iosWidget: CupertinoTextField(
                  placeholder: "iOS cupertino textfield",
                ),
              ),
            ],
          ),
          Section(
            title: "WidgetDisposer",
            subtitle: "dispose callback for stateless widget",
            isRow: false,
            children: [
              _MyStatelessWidget(),
            ],
          ),
          const Section(
            title: "ValueNotifierWrapper",
            subtitle: "using ValueNotifier in stateless widget",
            isRow: false,
            children: [
              _MyOtherStatelessWidget(),
            ],
          ),
          Section(
            title: "ConditionalWidget",
            subtitle: "ternary widget builder",
            isRow: false,
            children: [
              ConditionalWidget(
                condition: false,
                onTrue: () => const Text("Show when true"),
                onFalse: () => const Text("Show when false"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyOtherStatelessWidget extends StatelessWidget {
  const _MyOtherStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueNotifierWrapper<bool>(
      initialValue: false,
      builder: (valueNotifier, value, child) => SkadiLoadingButton(
        loadingNotifier: valueNotifier,
        onPressed: () async {
          valueNotifier.value = true;
          await SkadiUtils.wait();
          valueNotifier.value = false;
        },
        child: const Text("Click me"),
      ),
    );
  }
}

class _MyStatelessWidget extends StatelessWidget {
  final ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  _MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetDisposer(
      onDispose: () {
        print("This stateless widget now call dispose");

        ///Dispose ChangeNotifier in StatelessWidget
        valueNotifier.dispose();
      },
      child: SkadiLoadingButton(
        loadingNotifier: valueNotifier,
        onPressed: () async {
          valueNotifier.value = true;
          await SkadiUtils.wait();
          valueNotifier.value = false;
        },
        child: const Text("Click me"),
      ),
    );
  }
}
