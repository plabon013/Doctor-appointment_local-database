import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'date_styled_widget.dart';

class DateTimeWidget extends StatelessWidget {
  final String date;
  final String time;
  const DateTimeWidget({required this.date, required this.time, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        DateStyledWidget(title: date),
        const SizedBox(
          width: 10,
        ),
        DateStyledWidget(title: time),
      ],
    );
  }
}
