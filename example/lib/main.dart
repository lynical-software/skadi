import 'package:flutter/material.dart';

import 'src/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skadi Flutter Example',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const RootPage(),
    );
  }
}
