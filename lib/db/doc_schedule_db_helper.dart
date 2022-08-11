import 'package:doctor_appointment/models/doc_schedule_model.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/hospital_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';

import 'database_helper.dart';

class DocScheduleDBHelper {
  // insert a doc schedule
  static Future<int> insertDocSchedule(
      DocScheduleModel docScheduleModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(docScheduleTableName, docScheduleModel.toMap());
  }

  // get doc schedule details
  static Future<List<Map<String, dynamic>>> getAllDocScheduleDetails(
      int id) async {
    final db = await DatabaseHelper.openDB();
    return db.rawQuery('''
      select *
      from $doctorTableName
      inner join $docScheduleTableName
      on $docScheduleTableName.$docScheduleTableColDoctorId= $doctorTableName.$doctorTableColId
      inner join $hospitalTableName
      on $hospitalTableName.$hospitalTableColId= $docScheduleTableName.$docScheduleTableColHospitalId
      inner join $scheduleTableName
      on $scheduleTableName.$scheduleTableColId= $docScheduleTableName.$docScheduleTableColScheduleId
      and $doctorTableName.$doctorTableColId = ?
      ''', [id]);
  }

  // update schedule
  static updateDocSchedule(DocScheduleModel docScheduleModel) async {
    final db = await DatabaseHelper.openDB();
    return db.update(
      docScheduleTableName,
      docScheduleModel.toMap(),
      where: '$docScheduleTableColId = ?',
      whereArgs: [docScheduleModel.id],
    );
  }
  // delete schedule
  static deleteDocSchedule(int id) async {
    final db = await DatabaseHelper.openDB();
    return db.delete(
      docScheduleTableName,
      where: '$docScheduleTableColId = ?',
      whereArgs: [id],
    );
  }

  /* =================== query ===============*/
  // get doctor by hospital id
  static Future<List<Map<String, dynamic>>> getDoctorByHopitalId(
      int id) async {
    final db = await DatabaseHelper.openDB();
    return db.rawQuery('''
      select *
      from $doctorTableName
      inner join $docScheduleTableName
      on $docScheduleTableName.$docScheduleTableColDoctorId= $doctorTableName.$doctorTableColId
      inner join $hospitalTableName
      on $hospitalTableName.$hospitalTableColId= $docScheduleTableName.$docScheduleTableColHospitalId
      inner join $scheduleTableName
      on $scheduleTableName.$scheduleTableColId= $docScheduleTableName.$docScheduleTableColScheduleId
      and $hospitalTableName.$hospitalTableColId = ?
      and $doctorTableName.$doctorTableColIsAdmin = ?
      ''', [id, 0]);
  }
}
