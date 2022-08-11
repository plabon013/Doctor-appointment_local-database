import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class TitleButtonLayout extends StatelessWidget {
  final List<Widget> children;
  const TitleButtonLayout({
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
