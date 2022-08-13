import 'package:flutter/material.dart';

///Create a horizontal blank space
class SpaceX extends StatelessWidget {
  final double width;

  ///Create a horizontal blank space
  const SpaceX([this.width = 8, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

///Create a vertical blank space
class SpaceY extends StatelessWidget {
  final double height;

  ///Create a vertical blank space
  const SpaceY([this.height = 8, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

const emptySizedBox = SizedBox.shrink();
