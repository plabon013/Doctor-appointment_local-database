import 'package:flutter/material.dart';

import 'custom_text.dart';

class HospitalCardOne extends StatelessWidget {
  final String hospitalName;
  final String hospitalAddress;
  const HospitalCardOne({
    required this.hospitalName,
    required this.hospitalAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: hospitalName,
              fontSize: 14,
            ),
            CustomText(
              text: hospitalAddress,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
