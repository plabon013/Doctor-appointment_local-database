import 'dart:io';

import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/views/pages/admin/doctor_details_page.dart';
import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class DoctorCardOne extends StatelessWidget {
  final String name;
  // final String specialist;
  final double rating;
  final String institute;
  final int doctorId;
  final int specialityId;
  String? image;
  bool isDetailsPage;
  DoctorCardOne({
    required this.doctorId,
    required this.specialityId,
    required this.name,
    required this.institute,
    required this.rating,

    this.image,
    this.isDetailsPage = false,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  // TODO
                  child: image != null ? Image.file(
                    File(image!),
                    height:  150,
                    width: 100,
                    fit: BoxFit.cover,
                  ):Image.asset(
                    'images/doctor.jpg',
                    height:  150,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor name widget
                  CustomText(
                    text: name,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // speciality
                  // CustomText(
                  //   text: 'TODO speciality doctor card',
                  //   isTitle: false,
                  //   fontSize: 14,
                  // ),

                  //specialities widget
                  Consumer<DoctorProvider>(
                    builder: (context, doctorProvider, child) =>  FutureBuilder<String>(
                      future: doctorProvider.getSpecialityOfDoctor(specialityId),
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
                  ),


                  // FutureBuilder<String>(
                  //   future: Provider.of<DoctorProvider>(context,listen: false).getAllSpecialitiesOfDoctor(doctorId),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData){
                  //       return CustomText(
                  //         text: snapshot.data!,
                  //         isTitle: false,
                  //         fontSize: 14,
                  //       );
                  //     }
                  //     else if(snapshot.hasError){
                  //       return CustomText(
                  //         text: 'Speciality not added',
                  //         isTitle: false,
                  //         fontSize: 14,
                  //       );
                  //     }else{
                  //       return const CircularProgressIndicator();
                  //     }
                  //   }
                  // ),
                  const SizedBox(
                    height: 5,
                  ),

                  //institute
                  CustomText(
                    text: institute,
                    isTitle: false,
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //Rating row widget
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade900,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: rating.toString(),
                        fontSize: 14,
                        isTitle: false,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  // Date time row
                  // if (isDetailsPage == false)
                    DateTimeWidget(
                      date: 'date',
                      time: 'time',
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
