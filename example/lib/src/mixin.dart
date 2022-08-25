import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class SkadiMixinExample extends StatefulWidget {
  const SkadiMixinExample({Key? key}) : super(key: key);

  @override
  State<SkadiMixinExample> createState() => _SkadiMixinExampleState();
}

class _SkadiMixinExampleState extends State<SkadiMixinExample> with DeferDispose {
  late TextEditingController controller;

  @override
  void initState() {
    controller = createDefer(() => TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
