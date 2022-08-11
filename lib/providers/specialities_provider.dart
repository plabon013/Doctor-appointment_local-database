import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/db/specialities_db_helper.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/specialities_model.dart';
import 'package:flutter/material.dart';

import '../db/database_helper.dart';

class SpecialitiesProvider extends ChangeNotifier {
  List<SpecialitiesModel> specialitiesList = [];

  String? specialityName;
  SpecialitiesModel? selectedSpeciality;

  void selectSpeciality(SpecialitiesModel _selectedSpeciality) {
    selectedSpeciality = _selectedSpeciality;
    notifyListeners();
  }

//  ========================= database operation ===================
//  insert
  Future<bool> insertSpecialities() async {
    if (specialityName != null) {
      final sModel = await findSpecialityByName(specialityName);
      if (sModel.id == null) {
        SpecialitiesModel specialitiesModel =
            SpecialitiesModel(name: specialityName);
        print(specialitiesModel);

        int rowId =
            await SpecialitiesDBHelper.insertSpecialities(specialitiesModel);
        if (rowId > 0) {
          getAllSpecialities();
          return true;
        }
      } else {
        showToast('This speciality already present');
        return false;
      }
    }
    showToast('This field can not be empty');
    return false;
  }

  getAllSpecialities() async {
    List<Map<String, dynamic>> listMap =
        await SpecialitiesDBHelper.getAllSpecialities();
    specialitiesList = List.generate(
      listMap.length,
      (index) => SpecialitiesModel.fromMap(listMap[index]),
    );
    if (specialitiesList.isNotEmpty) {
      selectedSpeciality = specialitiesList.first;
      notifyListeners();
    }
  }

  // find speciality by name
  Future<SpecialitiesModel> findSpecialityByName(String? name) async {
    final List<Map<String, dynamic>> listMap =
        await SpecialitiesDBHelper.findSpecialityByName(name!);
    if (listMap.isNotEmpty) {
      return SpecialitiesModel.fromMap(listMap.first);
    } else {
      return SpecialitiesModel();
    }
  }

//  get all specialities

  //  check doctor id already present or not
  // Future<bool> checkDoctorInSpecialities(
  //     SpecialitiesModel specialitiesModel) async {
  //   List<Map<String, dynamic>> listMap =
  //       await SpecialitiesDBHelper.checkDoctorIdInSpecialities(
  //           specialitiesModel);
  //   if (listMap.isEmpty) {
  //     return false;
  //   }
  //   return true;
  // }
}
