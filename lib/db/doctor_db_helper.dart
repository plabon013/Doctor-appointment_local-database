import 'package:doctor_appointment/models/specialities_model.dart';

import '../models/doctor_model.dart';
import 'database_helper.dart';

class DoctorDBHelper {
  // static final String findDoctorsInSpeciality =

  // insert a doctor
  static Future<int> insertDoctor(DoctorModel doctorModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(doctorTableName, doctorModel.toMap());
  }

  //  find a doctor by email
  static Future<List<Map<String, dynamic>>> findDoctorByEmail(
    String email,
  ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      doctorTableName,
      where: '$doctorTableColEmail = ? AND $doctorTableColIsAdmin = ?',
      whereArgs: [email, 0],
    );
  }

  //  find a doctor by id
  static Future<List<Map<String, dynamic>>> findDoctorById(
    int id,
  ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      doctorTableName,
      where: '$doctorTableColId = ?',
      whereArgs: [id],
    );
  }

//  get all doctor
  static getAllDoctor() async {
    final db = await DatabaseHelper.openDB();
    return db.query(doctorTableName, where: '$doctorTableColIsAdmin = ?', whereArgs: [0],);
  }

  //  delete a doctor by id
  static Future<int> deleteDoctorById(
    int id,
  ) async {
    final db = await DatabaseHelper.openDB();
    return db.delete(
      doctorTableName,
      where: '$doctorTableColId = ?',
      whereArgs: [id],
    );
  }

  //  update a doctor by id
  static Future<int> updateDoctor(DoctorModel doctorModel) async {
    final db = await DatabaseHelper.openDB();
    return db.update(doctorTableName, doctorModel.toMap(),
        where: '$doctorTableColId = ?', whereArgs: [doctorModel.id]);
  }

  //  get speciality of a doctor
  static Future<List<Map<String, dynamic>>> getAllSpecialitiesOfDoctor(int specialityId) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      specialitiesTableName,
      distinct: true,
      where: '$specialitiesTableColId = ?',
      whereArgs: [specialityId],
    );
  }

//  login check
  static Future<List<Map<String, dynamic>>> checkLogin(String email, String password) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      doctorTableName,
      distinct: true,
      where: '$doctorTableColEmail = ? AND $doctorTableColPassword = ?',
      whereArgs: [email, password],
    );
 }


}
