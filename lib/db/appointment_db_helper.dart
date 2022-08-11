import 'package:doctor_appointment/models/appointment_model.dart';

import 'database_helper.dart';

class AppointmentDBHelper {
// insert a appointment
  static Future<int> insertAppointment(
      AppointmentModel appointmentModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(appointmentTableName, appointmentModel.toMap());
  }

//  get all appointment
  static getAllAppointment() async {
    final db = await DatabaseHelper.openDB();
    return db.query(appointmentTableName);
  }

  // //  get all appointment by doctor id
  // static getAllAppointmentByDoctorId(int id) async {
  //   final db = await DatabaseHelper.openDB();
  //   return db.query(
  //     appointmentTableName,
  //     where: '$appointmentTableColDoctorId = ?',
  //     whereArgs: [id],
  //   );
  // }

  //  delete a appointment by id
  // static Future<int> deleteAppointmentByDoctorIdHospitalIdScheduleId(
  //   int doctorId,
  //   int hospitalId,
  //   int scheduleId,
  // ) async {
  //   final db = await DatabaseHelper.openDB();
  //   return db.delete(
  //     appointmentTableName,
  //     where: '''$appointmentTableColDoctorId = ?
  //               AND $appointmentTableColHospitalId = ?
  //               AND $appointmentTableColScheduleId = ?
  //             ''',
  //     whereArgs: [doctorId, hospitalId, scheduleId],
  //   );
  // }
  //
  // //  update a appointment by id
  // static Future<int> updateAppointment(
  //     AppointmentModel appointmentModel) async {
  //   final db = await DatabaseHelper.openDB();
  //   return db.update(appointmentTableName, appointmentModel.toMap(),
  //       where: '''$appointmentTableColDoctorId = ?
  //                AND $appointmentTableColHospitalId = ?
  //                AND $appointmentTableColScheduleId = ?
  //              ''',
  //       whereArgs: [
  //         appointmentModel.doctorId,
  //         appointmentModel.hospitalId,
  //         appointmentModel.scheduleId
  //       ]);
  // }
}
