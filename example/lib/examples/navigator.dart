import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_example/main.dart';
import 'package:skadi_example/widgets/example_scaffold.dart';
import 'package:skadi_example/widgets/section.dart';

class SkadiNavigatorExample extends StatefulWidget {
  const SkadiNavigatorExample({Key? key}) : super(key: key);

  @override
  State<SkadiNavigatorExample> createState() => _SkadiNavigatorExampleState();
}

class _SkadiNavigatorExampleState extends State<SkadiNavigatorExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: "Skadi Navigator",
      children: [
        Section(
          title: "Push",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(const SecondPage());
              },
              child: const Text("Push To New Page"),
            ),
          ],
        ),
        Section(
          title: "PushReplacement",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushReplacement(const SecondPage());
              },
              child: const Text("PushReplacement To New Page"),
            ),
          ],
        ),
        Section(
          title: "PushRemove",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                SkadiNavigator.pushAndRemove(
                  context,
                  const RootPage(),
                  routeName: "/",
                );
              },
              child: const Text("PushRemove To Home Page"),
            ),
          ],
        ),
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: "Second",
      children: [
        Section(
          title: "PopAll",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.popAll();
              },
              child: const Text("PopAll to Home"),
            ),
          ],
        ),
        Section(
          title: "Push to this Page",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () => SkadiNavigator.push(
                context,
                const SecondPage(),
                replaceIfExist: true,
              ),
              child: const Text("Push"),
            ),
          ],
        ),
        Section(
          title: "Pop x time",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.popTime(2);
              },
              child: const Text("Pop 2 times to Home"),
            ),
          ],
        ),
        Section(
          title: "Pop All And Push",
          subtitle:
              "Expected to push to ThirdPage and page stack becomes [ RootPage, ThirdPage]",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                debugLog(SkadiRouteObserver.history);
                SkadiRouteObserver.popUntilRoute(context, "/");
                context.push(const ThirdPage());
              },
              child: const Text("Pop 2 times and Push"),
            ),
          ],
        ),
        Section(
          title: "To Third Page",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(const ThirdPage());
              },
              child: const Text("Push To Third Page"),
            ),
          ],
        ),
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: "Third",
      children: [
        Section(
          title: "Pop 3 time",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                context.popTime(3);
              },
              child: const Text("Pop 3 times to go to Home"),
            ),
          ],
        ),
        Section(
          title: "Pop to Route",
          isRow: true,
          children: [
            ElevatedButton(
              onPressed: () {
                SkadiRouteObserver.popUntilRoute(
                    context, "SkadiNavigatorExample");
              },
              child: const Text(
                "Pop to the page that you know the route name\nExample: SkadiNavigatorExample",
                textAlign: TextAlign.center,
              ),
            ).expanded,
          ],
        ),
      ],
    );
  }
}
