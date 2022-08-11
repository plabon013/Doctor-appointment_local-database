import 'package:doctor_appointment/models/patient_model.dart';

import 'database_helper.dart';

class PatientDBHelper{
  // insert a patient
  static Future<int> insertPatient(PatientModel patientModel) async {
    final db = await DatabaseHelper.openDB();
    return db.insert(patientTableName, patientModel.toMap());
  }
}