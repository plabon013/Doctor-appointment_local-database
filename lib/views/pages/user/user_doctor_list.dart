import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/pages/user/user_details_page.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/doctor_card_one.dart';

class UserDoctorList extends StatelessWidget {
  static const routeName = '/user_doctor_list';
  const UserDoctorList({Key? key,}) : super(key: key);

  showConfirmDialog(
      BuildContext context,
      String title,
      String contentText,
      VoidCallback onPressYes,
      ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: CustomText(text: title),
        content: CustomText(
          text: contentText,
          letterSpacing: 0,
          isTitle: false,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: CustomText(isTitle: false, text: 'NO'),
          ),
          ElevatedButton(
            onPressed: onPressYes,
            child: CustomText(
              isTitle: false,
              color: Colors.white,
              text: 'YES',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const Text('Doctor List'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline4?.copyWith(
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, doctorProvider, child) {
          if (doctorProvider.doctorList.isEmpty){
            return Center(
              child: CustomText(text: 'Doctor is Unavailable'),
            );
          }
          // doctorProvider.getAllDoctor();
          return ListView.builder(
            itemCount:doctorProvider.doctorList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap:  () {
                doctorProvider.setCurrentDoctor(doctorProvider.doctorList[index]);
                Navigator.pushNamed(
                  context,
                  UserDetailsPage.routeName,
                  arguments: doctorProvider.doctorList[index].id,
                );
              },
              child: DoctorCardOne(
                doctorId: doctorProvider.doctorList[index].id!,
                name: doctorProvider.doctorList[index].name!,
                specialityId: doctorProvider.doctorList[index].specialityId ?? -99,
                // specialist: 'specialist',
                institute: doctorProvider.doctorList[index].institute!,
                rating: doctorProvider.doctorList[index].rating!,
                image: doctorProvider.doctorList[index].image,
              ),
            ),
          );
        },
      ),
    );
  }
}
