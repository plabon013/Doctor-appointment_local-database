import 'package:doctor_appointment/models/patient_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';

import 'appointment_model.dart';
import 'doc_schedule_model.dart';
import 'doctor_model.dart';
import 'hospital_model.dart';

class CommonModel {
  //doctor info
  int? doctorId;
  String? doctorName;
  String? doctorMobile;
  String? doctorEmail;
  String? doctorGender;
  String? doctorInstitute;
  String? doctorQualification;
  String? doctorImage;
  double? doctorRating;
  String? doctorDescription;
  int? doctorSpecialityId;

//  hospital
  int? hospitalId;
  String? hospitalName;
  String? hospitalAddress;

//  schedule
  int? scheduleId;
  String? scheduleDate;
  String? scheduleTime;

  // patient
  int? patientId;
  String? patientName;
  String? patientMobile;
  String? patientEmail;
  String? patientAddress;

  //docSchedule
  int? docScheduleId;
  int? docScheduleDoctorId;
  int? docScheduleScheduleId;
  int? docScheduleHospitalId;

  //appointment
  int? appointmentId;
  int? appointmentDocScheduleId;
  int? appointmentPatientId;


  CommonModel({
    this.doctorId,
    this.doctorName,
    this.doctorMobile,
    this.doctorEmail,
    this.doctorGender,
    this.doctorInstitute,
    this.doctorQualification,
    this.doctorImage,
    this.doctorRating,
    this.doctorDescription,
    this.doctorSpecialityId,
    this.hospitalId,
    this.hospitalName,
    this.hospitalAddress,
    this.scheduleId,
    this.scheduleDate,
    this.scheduleTime,
    this.patientId,
    this.patientName,
    this.patientMobile,
    this.patientEmail,
    this.patientAddress,
    this.docScheduleId,
    this.docScheduleDoctorId,
    this.docScheduleScheduleId,
    this.docScheduleHospitalId,
    this.appointmentId,
    this.appointmentDocScheduleId,
    this.appointmentPatientId,
  });


  @override
  String toString() {
    return 'CommonModel{doctorId: $doctorId, doctorName: $doctorName, doctorMobile: $doctorMobile, doctorEmail: $doctorEmail, doctorGender: $doctorGender, doctorInstitute: $doctorInstitute, doctorQualification: $doctorQualification, doctorImage: $doctorImage, doctorRating: $doctorRating, doctorDescription: $doctorDescription, doctorSpecialityId: $doctorSpecialityId, hospitalId: $hospitalId, hospitalName: $hospitalName, hospitalAddress: $hospitalAddress, scheduleId: $scheduleId, scheduleDate: $scheduleDate, scheduleTime: $scheduleTime, patientId: $patientId, patientName: $patientName, patientMobile: $patientMobile, patientEmail: $patientEmail, patientAddress: $patientAddress, docScheduleId: $docScheduleId, docScheduleDoctorId: $docScheduleDoctorId, docScheduleScheduleId: $docScheduleScheduleId, docScheduleHospitalId: $docScheduleHospitalId, appointmentId: $appointmentId, appointmentDocScheduleId: $appointmentDocScheduleId, appointmentPatientId: $appointmentPatientId}';
  }

  factory CommonModel.fromMap(Map<String, dynamic> map) {
    return CommonModel(
      //doctor
      doctorId: map[doctorTableColId],
      doctorName: map[doctorTableColName],
      doctorGender: map[doctorTableColGender],
      doctorMobile: map[doctorTableColMobile],
      doctorEmail: map[doctorTableColEmail],
      doctorQualification: map[doctorTableColQualification],
      doctorInstitute: map[doctorTableColInstitute],
      doctorImage: map[doctorTableColImage],
      doctorRating: map[doctorTableColRating] ?? -99.0,
      doctorDescription: map[doctorTableColDescription],
      doctorSpecialityId: map[doctorTableColSpecialityId],

      // hospital
      hospitalId: map[hospitalTableColId],
      hospitalName: map[hospitalTableColName],
      hospitalAddress: map[hospitalTableColAddress],

      // schedule
      scheduleId: map[scheduleTableColId],
      scheduleDate: map[scheduleTableColDate],
      scheduleTime: map[scheduleTableColTime],

      // patient
      patientId: map[patientTableColId],
      patientName: map[patientTableColName],
      patientMobile: map[patientTableColMobile],
      patientEmail: map[patientTableColEmail],
      patientAddress: map[patientTableColAddress],

      // docSchedule
      docScheduleId: map[docScheduleTableColId],
      docScheduleDoctorId: map[docScheduleTableColDoctorId],
      docScheduleScheduleId: map[docScheduleTableColScheduleId],
      docScheduleHospitalId: map[docScheduleTableColHospitalId],

    //  Appointment
      appointmentId: map[appointmentTableColId],
      appointmentDocScheduleId: map[appointmentTableColDocScheduleId],
      appointmentPatientId: map[appointmentTableColPatientId],
    );
  }
}
