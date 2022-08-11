import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/db/hospital_db_helper.dart';
import 'package:doctor_appointment/models/hospital_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';
import 'package:flutter/material.dart';

import '../db/doctor_db_helper.dart';

class HospitalProvider extends ChangeNotifier {
  List<HospitalModel> hospitalList = [];

  // ===================== doctor info =====================
  String? name;
  String? address;
  HospitalModel? selectedHospital;

  void setName(String value) {
    name = value;
  }

  void setAddress(String value) {
    address = value;
  }

  void selectHospital(HospitalModel _selectedHospital) {
    selectedHospital = _selectedHospital;
    notifyListeners();
  }

  /* =========== database operation ============*/
  // insert hospital
  Future<bool> insertHospital() async {
    if (name != null && address != null) {
      HospitalModel hospitalModel = HospitalModel(
        name: name,
        address: address,
      );

      HospitalModel checkHospital =
          await findHospitalByNameAndAddress(name!, address!);
      if (checkHospital.id == null) {
        int rowId = await HospitalDBHelper.insertHospital(hospitalModel);
        if (rowId > 0) {
          showToast('Inserted successfully');
          name = null;
          address = null;
          getAllHospital();
          return true;
        } else {
          showToast('Hospital insertion failed');
        }
      }
    }
    showToast('Hospital insertion failed');
    return false;
  }

//  get all hospital
  getAllHospital() async {
    final List<Map<String, dynamic>> listMap =
        await HospitalDBHelper.getAllHospital();

    hospitalList = List.generate(
      listMap.length,
      (index) => HospitalModel.fromMap(listMap[index]),
    );

    if (hospitalList.isNotEmpty) {
      selectedHospital = hospitalList.first;

      notifyListeners();
    }
  }

  //  find hospital by name
  Future<HospitalModel> findHospitalByName(String name) async {
    final List<Map<String, dynamic>> listMap =
        await HospitalDBHelper.findHospitalByName(name);
    if (listMap.isNotEmpty) {
      return HospitalModel.fromMap(listMap.first);
    } else {
      return HospitalModel();
    }
  }

  //  find hospital by address
  Future<HospitalModel> findHospitalByAddress(String address) async {
    final List<Map<String, dynamic>> listMap =
        await HospitalDBHelper.findHospitalByAddress(address);
    if (listMap.isNotEmpty) {
      return HospitalModel.fromMap(listMap.first);
    } else {
      return HospitalModel();
    }
  }

  //  find hospital by name address
  Future<HospitalModel> findHospitalByNameAndAddress(
      String name, String address) async {
    final List<Map<String, dynamic>> listMap =
        await HospitalDBHelper.findHospitalByNameAndAddress(name, address);
    if (listMap.isNotEmpty) {
      return HospitalModel.fromMap(listMap.first);
    } else {
      return HospitalModel();
    }
  }
}
