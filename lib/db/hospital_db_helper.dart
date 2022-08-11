import 'package:doctor_appointment/models/hospital_model.dart';
import 'database_helper.dart';

class HospitalDBHelper {
  // insert a hospital
  static Future<int> insertHospital(HospitalModel hospitalModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(hospitalTableName, hospitalModel.toMap());
  }

//  get all hospital
  static getAllHospital() async {
    final db = await DatabaseHelper.openDB();
    return db.query(hospitalTableName);
  }

  //  delete a hospital by id
  static Future<int> deleteHospitalById(
      int id,
      ) async {
    final db = await DatabaseHelper.openDB();
    return db.delete(
      hospitalTableName,
      where: '$hospitalTableColId = ?',
      whereArgs: [id],
    );
  }

  //  update a hospital by id
  static Future<int> updateHospital(HospitalModel hospitalModel) async {
    final db = await DatabaseHelper.openDB();
    return db.update(hospitalTableName, hospitalModel.toMap(),
        where: '$hospitalTableColId = ?', whereArgs: [hospitalModel.id]);
  }

  //  find a hospital by name
  static Future<List<Map<String, dynamic>>> findHospitalByName(
      String name,
      ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      hospitalTableName,
      where: '$hospitalTableColName = ?',
      whereArgs: [name],
    );
  }

  //  find a hospital by address
  static Future<List<Map<String, dynamic>>> findHospitalByAddress(
      String address,
      ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      hospitalTableName,
      where: '$hospitalTableColAddress = ?',
      whereArgs: [address],
    );
  }
  //  find a hospital by name and address
  static Future<List<Map<String, dynamic>>> findHospitalByNameAndAddress(
      String name,
      String address,
      ) async {
    final db = await DatabaseHelper.openDB();
    return db.query(
      hospitalTableName,
      where: '$hospitalTableColName = ? AND $hospitalTableColAddress = ?',
      whereArgs: [name, address],
    );
  }



}
