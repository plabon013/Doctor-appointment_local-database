import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/pages/user/user_details_page.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/doctor_card_one.dart';

class UserSpecialityDoctor extends StatelessWidget {
  static const routeName = '/user_speciality_doctor';
  const UserSpecialityDoctor({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    int specialityId = ModalRoute.of(context)?.settings.arguments as int;
    Provider.of<DoctorProvider>(context,listen: false).findDoctorsBySpeciality(specialityId);

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
          if (doctorProvider.doctorListBySpecialities.isEmpty){
            return Center(
              child: CustomText(text: 'Doctor is Unavailable'),
            );
          }
          return ListView.builder(
            itemCount: doctorProvider.doctorListBySpecialities.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: (){
                doctorProvider.setCurrentDoctor(doctorProvider.doctorList[index]);
                Navigator.pushNamed(
                  context,
                  UserDetailsPage.routeName,
                  arguments: doctorProvider.doctorList[index].id,
                );
              },
              child: DoctorCardOne(
                doctorId: doctorProvider.doctorListBySpecialities[index].id!,
                name: doctorProvider.doctorListBySpecialities[index].name!,
                specialityId: doctorProvider.doctorListBySpecialities[index].specialityId!,
                institute: doctorProvider.doctorListBySpecialities[index].institute!,
                rating:  doctorProvider.doctorListBySpecialities[index].rating!,
                image: doctorProvider.doctorListBySpecialities[index].image,
              ),
            ),
          );
        },
      ),
    );
  }
}
