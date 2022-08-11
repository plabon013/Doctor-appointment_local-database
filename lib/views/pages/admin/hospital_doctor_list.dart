import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/doctor_card_one.dart';
import 'doctor_details_page.dart';

class HospitalDoctorList extends StatelessWidget {
  static const routeName = '/hospital_doctor';
  const HospitalDoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int hospitalId = ModalRoute.of(context)?.settings.arguments as int;
    // Provider.of<DoctorProvider>(context,listen: false).findDoctorsBySpeciality(specialityId);

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
          if (doctorProvider.doctorInHospitalList.isEmpty) {
            return Center(
              child: CustomText(text: 'Doctor is Unavailable'),
            );
          }
          return ListView.builder(
            itemCount: doctorProvider.doctorInHospitalList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                doctorProvider
                    .setCurrentDoctor(doctorProvider.doctorList[index]);
                Navigator.pushNamed(
                  context,
                  DoctorDetailsPage.routeName,
                  arguments: doctorProvider.doctorList[index].id,
                );
              },
              child: DoctorCardOne(
                doctorId: doctorProvider.doctorInHospitalList[index].id!,
                name: doctorProvider.doctorInHospitalList[index].name!,
                specialityId:
                    doctorProvider.doctorInHospitalList[index].specialityId!,
                institute:
                    doctorProvider.doctorInHospitalList[index].institute!,
                rating: doctorProvider.doctorInHospitalList[index].rating!,
                image: doctorProvider.doctorInHospitalList[index].image,
              ),
            ),
          );
        },
      ),
    );
  }
}
