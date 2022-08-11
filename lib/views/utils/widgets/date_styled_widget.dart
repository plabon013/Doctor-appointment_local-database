import 'package:flutter/material.dart';

import 'custom_text.dart';

class DateStyledWidget extends StatelessWidget {
  final String title;
  const DateStyledWidget({required this.title, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        isTitle: false,
        text: title,
        fontSize: 12,
        color: Colors.white54,
      ),
    );
  }
}
