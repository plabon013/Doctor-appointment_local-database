import 'package:doctor_appointment/providers/appointment_provider.dart';
import 'package:doctor_appointment/providers/doc_schedule_provider.dart';
import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/providers/hospital_provider.dart';
import 'package:doctor_appointment/providers/schedule_provider.dart';
import 'package:doctor_appointment/providers/specialities_provider.dart';
import 'package:doctor_appointment/providers/user_handler_provider.dart';
import 'package:doctor_appointment/views/doctor_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // sta
        statusBarIconBrightness: Brightness.dark // tus bar color
        ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DoctorProvider()..getAllDoctor(),
        ),
        ChangeNotifierProvider(
          create: (context) => SpecialitiesProvider()..getAllSpecialities(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider()..getAllSchedule(),
        ),
        ChangeNotifierProvider(
          create: (context) => HospitalProvider() ..getAllHospital(),
        ),
        ChangeNotifierProvider(
          create: (context) => DocScheduleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserHandlerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppointmentProvider(),
        ),
      ],
      child: const DoctorApp(),
    ),
  );
}
