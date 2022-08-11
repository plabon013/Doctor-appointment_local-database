import 'dart:io';

import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/doctor_provider.dart';
import '../../pages/admin/doctor_details_page.dart';
import 'custom_text.dart';

class DoctorCardTwo extends StatelessWidget {
  final int specialityId;
  final String name;
  // final String specialist;
  final double rating;
  final String institute;
  String? image;
  DoctorCardTwo({
    required this.specialityId,
    required this.name,
    // required this.specialist,
    required this.institute,
    required this.rating,
    this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // TODO
                child: image != null
                    ? Image.file(
                        File(image!),
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'images/doctor.jpg',
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.6,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  FutureBuilder<String>(
                    future: Provider.of<DoctorProvider>(context, listen: false).getSpecialityOfDoctor(specialityId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        return  CustomText(
                              text: snapshot.data!,
                              isTitle: false,
                              fontSize: 13,
                            );
                      }
                      else if (snapshot.hasError){
                      return  CustomText(
                              text: 'No speciality found',
                              isTitle: false,
                              fontSize: 13,
                            );
                      }
                      else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),

                  // CustomText(
                  //   text: specialist,
                  //   isTitle: false,
                  //   fontSize: 13,
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: institute,
                    isTitle: false,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade900,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: rating.toString(),
                        fontSize: 12,
                        isTitle: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
