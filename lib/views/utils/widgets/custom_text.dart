import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  bool isTitle;
  double fontSize;
  Color color;
  double letterSpacing;

  CustomText({
    required this.text,
    this.fontSize = 16,
    this.isTitle = true,
    this.color = Colors.grey,
    this.letterSpacing = 1.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        color: isTitle ? Colors.black54 : color,
        letterSpacing: letterSpacing,
      ),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.fade,
    );
  }
}
