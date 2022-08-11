import 'package:doctor_appointment/db/doc_schedule_db_helper.dart';
import 'package:doctor_appointment/models/common_model.dart';
import 'package:doctor_appointment/models/doc_schedule_model.dart';
import 'package:flutter/cupertino.dart';

import '../constents/toast.dart';

class DocScheduleProvider extends ChangeNotifier {
  List<CommonModel> commonModelList = [];

  CommonModel? selectedSchedule;

  void selectSchedule(CommonModel _selectedHospital) {
    selectedSchedule = _selectedHospital;
    notifyListeners();
  }

//  insert
  Future<bool> insertDocSchedule(
      int doctorId, int hospitalId, int scheduleId) async {
    DocScheduleModel docScheduleModel = DocScheduleModel(
      doctorId: doctorId,
      hospitalId: hospitalId,
      scheduleId: scheduleId,
    );
    int rowId = await DocScheduleDBHelper.insertDocSchedule(docScheduleModel);
    if (rowId > 0) {
      showToast('Success');
      getDocScheduleDetails(doctorId);
      return true;
    }
    return false;
  }

// get doc schedule details
  getDocScheduleDetails(int id) async {
    final listMap = await DocScheduleDBHelper.getAllDocScheduleDetails(id);
    commonModelList = List.generate(
        listMap.length, (index) => CommonModel.fromMap(listMap[index]));
    if (commonModelList.isNotEmpty) {
      selectedSchedule = commonModelList.first;
      print(commonModelList);
      notifyListeners();
    }
  }

  //  update doc schedule
  Future<bool> updateDocSchedule(
      int doctorId, int hospitalId, int scheduleId, int id) async {
    DocScheduleModel docScheduleModel = DocScheduleModel(
      id: id,
      doctorId: doctorId,
      hospitalId: hospitalId,
      scheduleId: scheduleId,
    );
    int rowId = await DocScheduleDBHelper.updateDocSchedule(docScheduleModel);
    if (rowId > 0) {
      showToast('Success');
      getDocScheduleDetails(doctorId);
      return true;
    }
    return false;
  }

  //  update doc schedule
  Future<bool> deleteDocSchedule(int doctorId, int id) async {
    int rowId = await DocScheduleDBHelper.deleteDocSchedule(id);
    if (rowId > 0) {
      showToast('Success');
      getDocScheduleDetails(doctorId);
      return true;
    }
    return false;
  }

  /* ================= query ====================*/
  // get doctor by hospital id
  // static Future<List<Map<String, dynamic>>> getDoctorByHopitalId(
  //     int id) async {
  //
  // }

}
