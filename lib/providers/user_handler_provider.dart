import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/hospital_model.dart';
import 'package:doctor_appointment/models/specialities_model.dart';
import 'package:flutter/material.dart';

class UserHandlerProvider extends ChangeNotifier {
  List<String> searchFilter = [
    specialitiesTableColName,
    doctorTableColName,
    hospitalTableColName,
  ];
  String selectedFilter = specialitiesTableColName;
  String? email;
  String? password;
  setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }




}
