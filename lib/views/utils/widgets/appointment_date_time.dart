import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'custom_text_field.dart';

class AppointmentDateTime extends StatelessWidget {
  final String hospitalName;
  final String hospitalAddress;
  final String date;
  final String time;
  const AppointmentDateTime({
    required this.hospitalName,
    required this.hospitalAddress,
    required this.date,
    required this.time,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: hospitalName,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: hospitalAddress,
              isTitle: false,
            ),
            const SizedBox(
              height: 10,
            ),
            DateTimeWidget(
              date: date,
              time: time,
            ),
          ],
        ),
      ),
    );
  }
}
