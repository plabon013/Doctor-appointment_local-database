import 'package:flutter/material.dart';

import '../widgets/category_card.dart';

class CardListLayout extends StatelessWidget {
  final double height;
  final Widget child;
  const CardListLayout({
    required this.height,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: child,
    );
  }
}
