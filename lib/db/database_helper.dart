import 'package:doctor_appointment/models/doc_schedule_model.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/hospital_model.dart';
import 'package:doctor_appointment/models/patient_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';
import 'package:doctor_appointment/models/specialities_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/appointment_model.dart';

class DatabaseHelper {
  /* ===== doctor creating table sql =====*/
  static const String doctorTableCreateQuery = '''CREATE TABLE $doctorTableName(
  $doctorTableColId INTEGER PRIMARY KEY NOT NULL,
  $doctorTableColName TEXT,
  $doctorTableColGender  TEXT,
  $doctorTableColMobile TEXT,
  $doctorTableColEmail TEXT,
  $doctorTableColPassword TEXT,
  $doctorTableColQualification TEXT,
  $doctorTableColInstitute TEXT,
  $doctorTableColRating REAL,
  $doctorTableColImage TEXT,
  $doctorTableColDescription TEXT,
  $doctorTableColSpecialityId INTEGER,
  $doctorTableColIsAdmin INTEGER
  )''';

/* ===== specialities creating table sql =====*/
  static const String specialitiesTableCreateQuery =
      '''CREATE TABLE $specialitiesTableName(
  $specialitiesTableColId INTEGER PRIMARY KEY NOT NULL,
  $specialitiesTableColName TEXT
  )''';

  /* ===== schedule creating table sql =====*/
  static const String scheduleTableCreateQuery =
      '''CREATE TABLE $scheduleTableName(
  $scheduleTableColId INTEGER PRIMARY KEY NOT NULL,
  $scheduleTableColDate TEXT,
  $scheduleTableColTime TEXT
  )''';

  /* ===== hospital creating table sql =====*/
  static const String hospitalTableCreateQuery =
      '''CREATE TABLE $hospitalTableName(
  $hospitalTableColId INTEGER PRIMARY KEY NOT NULL,
  $hospitalTableColName TEXT,
  $hospitalTableColAddress TEXT
  )''';

  /* ===== doc schedule creating table sql =====*/
  static const String docScheduleTableCreateQuery =
      '''CREATE TABLE $docScheduleTableName(
  $docScheduleTableColId INTEGER PRIMARY KEY NOT NULL,
  $docScheduleTableColDoctorId INTEGER,
  $docScheduleTableColScheduleId INTEGER,
  $docScheduleTableColHospitalId INTEGER
  )''';
  /* ===== patient creating table sql =====*/
  static const String patientTableCreateQuery =
      '''CREATE TABLE $patientTableName(
  $patientTableColId INTEGER PRIMARY KEY NOT NULL,
  $patientTableColName TEXT,
  $patientTableColAddress TEXT,
  $patientTableColMobile TEXT,
  $patientTableColEmail TEXT
  )''';
  /* ===== appointment creating table sql =====*/
  static const String appointmentTableCreateQuery =
      '''CREATE TABLE $appointmentTableName(
  $appointmentTableColId INTEGER PRIMARY KEY NOT NULL,
  $appointmentTableColDocScheduleId INTEGER,
  $appointmentTableColPatientId INTEGER
  )''';

  static Future<Database> openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'doctor_app.db');

// open the database
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(doctorTableCreateQuery);
      await db.execute(specialitiesTableCreateQuery);
      await db.execute(scheduleTableCreateQuery);
      await db.execute(hospitalTableCreateQuery);

      await db.execute(docScheduleTableCreateQuery);
      await db.execute(patientTableCreateQuery);
      await db.execute(appointmentTableCreateQuery);

    });
  }

}
