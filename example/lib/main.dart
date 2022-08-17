import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import 'src/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        SkadiRouteObserver(log: true),
      ],
      title: 'Skadi Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const RootPage(),
    );
  }
}
