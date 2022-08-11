import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';


class ScheduleCard extends StatelessWidget {
  final String date;
  final String time;
  const ScheduleCard({
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
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: DateTimeWidget(
          date: date,
          time: time,
        ),
      ),
    );
  }
}
