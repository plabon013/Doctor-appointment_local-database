import 'package:flutter/material.dart';

import 'custom_text.dart';


class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.heart_broken,
              color: Colors.blue,
              size: 35,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: 'Cardiology',
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
