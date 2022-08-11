import 'package:doctor_appointment/db/appointment_db_helper.dart';
import 'package:doctor_appointment/db/patient_db_helper.dart';
import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/patient_model.dart';
import 'package:flutter/material.dart';

import '../constents/toast.dart';


class AppointmentProvider extends ChangeNotifier{
  String? name;
  String? mobile;
  String? email;
  String? address;
  // int? docScheduleId;

  //  insert
   Future<bool> insertAppointment(int? docScheduleId) async {
    PatientModel patientModel = PatientModel(
      name: name,
      mobile: mobile,
      email: email,
      address: address,
    );
    print(patientModel);
    int rowId = await PatientDBHelper.insertPatient(patientModel);
    if (rowId > 0) {


      AppointmentModel appointmentModel = AppointmentModel(
        docScheduleId: docScheduleId,
        patientId: rowId,
      );

      int appRowId = await AppointmentDBHelper.insertAppointment(appointmentModel);
      print(appRowId);
      showToast('Appointment Confirmed');
      return true;
    }
    return false;
  }


}