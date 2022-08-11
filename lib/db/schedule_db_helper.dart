import 'package:doctor_appointment/db/database_helper.dart';
import 'package:doctor_appointment/models/schedule_model.dart';

class ScheduleDBHelper {
  /* ====== insert new schedule ========= */
  static Future<int> insertSchedule(ScheduleModel scheduleModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(scheduleTableName, scheduleModel.toMap());
  }

//  get all schedule
  static getAllSchedule() async {
    final db = await DatabaseHelper.openDB();
    return db.query(scheduleTableName);
  }

  //  get new added schedule
  static getAddedSchedule(String date, String time) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      scheduleTableName,
      where: '''$scheduleTableColDate = ?
                AND $scheduleTableColTime = ?
              ''',
      whereArgs: [date, time],
    );
  }
}
