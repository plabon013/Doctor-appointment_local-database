import 'package:doctor_appointment/db/database_helper.dart';

import '../models/doctor_model.dart';
import '../models/specialities_model.dart';

// $specialitiesTableName.$specialitiesTableColId as specialities_id,
//     $specialitiesTableName.$specialitiesTableColName as specialities_name,
//     $specialitiesTableName.$specialitiesTableColDoctorId as specialities_doctor_id,
//     $doctorTableName.$doctorTableColId as doctor_id,
//     $doctorTableName.$doctorTableColName as doctor_name,
//     $doctorTableName.$doctorTableColMobile as doctor_mobile,
//     $doctorTableName.$doctorTableColMobile as doctor_mobile,

class SpecialitiesDBHelper {
//  insert into specialities table
  static Future<int> insertSpecialities(
      SpecialitiesModel specialitiesModel) async {
    final db = await DatabaseHelper.openDB();
    // await createSpecialitiesTable(db);
    return db.insert(specialitiesTableName, specialitiesModel.toMap());
  }

  static Future<List<Map<String, dynamic>>> getAllSpecialities() async {
    final db = await DatabaseHelper.openDB();
    return db.query(specialitiesTableName);
    // return db.query(specialitiesTableName);
  }

// find speciality by name
  static Future<List<Map<String, dynamic>>> findSpecialityByName(
    String name,
  ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      specialitiesTableName,
      where: '$specialitiesTableColName = ?',
      whereArgs: [name],
    );
  }

  // find speciality by name
  // static Future<List<Map<String, dynamic>>> findSpecialityByName(
  //   String name,
  // ) async {
  //   final db = await DatabaseHelper.openDB();
  //   return db.query(
  //     specialitiesTableName,
  //     where: '$specialitiesTableColName = ?',
  //     whereArgs: [name],
  //   );
  // }

  // get all specialities distinct value

  // get all specialities
  // static Future<List<Map<String, dynamic>>> checkDoctorIdInSpecialities(
  //     SpecialitiesModel specialitiesModel) async {
  //   final db = await DatabaseHelper.openDB();
  //   return db.query(
  //     specialitiesTableName,
  //     where:
  //         '$specialitiesTableColDoctorId = ? AND $specialitiesTableColName = ?',
  //     whereArgs: [specialitiesModel.doctorId, specialitiesModel.name],
  //   );
  // }
  //  find doctor bye speciality

  static  Future<List<Map<String, dynamic>>> findDoctorsBySpeciality(int specialityId) async {
    final db = await DatabaseHelper.openDB();
    return db.rawQuery(
      '''
      select *
      from $specialitiesTableName
      inner join $doctorTableName
      on $doctorTableName.$doctorTableColSpecialityId = $specialitiesTableName.$specialitiesTableColId
      and $specialitiesTableName.$specialitiesTableColId = ?
      and $doctorTableName.$doctorTableColIsAdmin = ?
      ''',

      [specialityId, 0]
    );
    // JOIN $doctorTableName ON $specialitiesTableName.$specialitiesTableColName = ?
  }
}
