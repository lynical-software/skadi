import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

class Section extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final bool isRow;
  const Section({
    Key? key,
    required this.title,
    required this.children,
    required this.isRow,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: EllipsisText(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          const SpaceY(16),
          if (isRow)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: children,
            )
          else
            ...children,
          const Divider(),
        ],
      ),
    );
  }
}
