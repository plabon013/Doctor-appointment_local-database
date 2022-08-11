import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/pages/admin/dashboard.dart';
import 'package:doctor_appointment/views/pages/admin/doctor_list.dart';
import 'package:doctor_appointment/views/pages/admin/hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/admin/hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/admin/speciality_doctor.dart';
import 'package:doctor_appointment/views/pages/admin/speciality_doctor.dart';
import 'package:doctor_appointment/views/pages/admin/doctor_details_page.dart';
import 'package:doctor_appointment/views/pages/login_page.dart';
import 'package:doctor_appointment/views/pages/login_page.dart';
import 'package:doctor_appointment/views/pages/search_page.dart';
import 'package:doctor_appointment/views/pages/search_page.dart';
import 'package:doctor_appointment/views/pages/user/appointment_page.dart';
import 'package:doctor_appointment/views/pages/user/appointment_page.dart';
import 'package:doctor_appointment/views/pages/doctor/doctor_home_page.dart';
import 'package:doctor_appointment/views/pages/doctor/doctor_home_page.dart';
import 'package:doctor_appointment/views/pages/user/create_appointment.dart';
import 'package:doctor_appointment/views/pages/user/home_page.dart';
import 'package:doctor_appointment/views/pages/user/home_page.dart';
import 'package:doctor_appointment/views/pages/user/user_details_page.dart';
import 'package:doctor_appointment/views/pages/user/user_details_page.dart';
import 'package:doctor_appointment/views/pages/user/user_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_speciality_doctor_page.dart';
import 'package:doctor_appointment/views/pages/user/user_speciality_doctor_page.dart';
import 'package:doctor_appointment/views/utils/auth/launcher_page.dart';
import 'package:doctor_appointment/views/utils/auth/launcher_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DoctorApp extends StatelessWidget {
  const DoctorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LauncherPage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DashBoard.routeName: (context) => const DashBoard(),
        DoctorHomePage.routeName: (context) => const DoctorHomePage(),
        LauncherPage.routeName: (context) => const LauncherPage(),
        DoctorList.routeName: (context) => const DoctorList(),
        AddDoctor.routeName: (context) => const AddDoctor(),
        DoctorDetailsPage.routeName: (context) => const DoctorDetailsPage(),
        UserDetailsPage.routeName: (context) => const UserDetailsPage(),
        SpecialityDoctor.routeName: (context) => const SpecialityDoctor(),
        AppointmentPage.routeName: (context) => const AppointmentPage(),
        SearchPage.routeName: (context) => const SearchPage(),
        HospitalDoctorList.routeName: (context) => const HospitalDoctorList(),
        LoginPage.routeName: (context) => const LoginPage(),
        UserDoctorList.routeName: (context) => const UserDoctorList(),
        UserSpecialityDoctor.routeName: (context) => const UserSpecialityDoctor(),
        UserHospitalDoctorList.routeName: (context) => const UserHospitalDoctorList(),
        CreateAppointment.routeName: (context) => const CreateAppointment(),
      },
      builder: EasyLoading.init(),
    );
  }
}
