import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Material(
          shape: SkadiDecoration.roundRect(12),
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SpaceX(24),
                Text("Please wait...", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
