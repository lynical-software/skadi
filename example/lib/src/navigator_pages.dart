import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class Detail1 extends StatelessWidget {
  const Detail1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            SkadiNavigator.push(context, const Detail2());
          },
          child: const Text("Detail 2"),
        ),
      ),
    );
  }
}

class Detail2 extends StatelessWidget {
  const Detail2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              SkadiRouteObserver.showRoutes();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            SkadiNavigator.pushReplacement(context, const Detail2());
          },
          child: const Text("Detail 2"),
        ),
      ),
    );
  }
}

class Detail3 extends StatelessWidget {
  const Detail3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // SkadiRouteObserver.showRoutes();
                SkadiNavigator.popAll(context);
              },
              child: const Text("Pop all"),
            ),
            ElevatedButton(
              onPressed: () {
                print(SkadiNavigator.currentRoute(context));
              },
              child: const Text("Current route"),
            ),
            ElevatedButton(
              onPressed: () {
                // SkadiRouteObserver.showRoutes();
                SkadiNavigator.popAll(context);
              },
              child: const Text("Pop all"),
            ),
          ],
        ),
      ),
    );
  }
}
