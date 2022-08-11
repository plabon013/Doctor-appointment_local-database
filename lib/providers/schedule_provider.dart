import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/models/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/schedule_db_helper.dart';

class ScheduleProvider extends ChangeNotifier {
  List<ScheduleModel> scheduleList = [];
  ScheduleModel? selectedSchedule;

  String? date;
  String? time;

  // set date by user
  setDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (selectedDate != null) {
      date = DateFormat('dd/MM/yyyy').format(selectedDate);
      notifyListeners();
    }
  }

  // set time by user
  setTime(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      time = selectedTime.format(context);
      notifyListeners();
    }
  }

  selectSchedule(ScheduleModel value) {
    selectedSchedule = value;
    notifyListeners();
  }

//  ================= database operation ====================
//  insert schedule
  Future<bool> insertSchedule() async {
    if (date != null && time != null) {
      ScheduleModel scheduleModel = ScheduleModel(
        date: date,
        time: time,
      );
      int rowId = await ScheduleDBHelper.insertSchedule(scheduleModel);
      if (rowId > 0) {
        getAllSchedule();
        showToast('Schedule added successfully');
        return true;
      } else {
        showToast('Failed to add new schedule');
        return false;
      }
    } else {
      showToast('Select date and time');
      return false;
    }
  }

//  get All schedule
  getAllSchedule() async {
    final List<Map<String, dynamic>> listMap =
        await ScheduleDBHelper.getAllSchedule();

    scheduleList = List.generate(
      listMap.length,
      (index) => ScheduleModel.fromMap(listMap[index]),
    );
    if (scheduleList.isNotEmpty) {
      selectedSchedule = scheduleList.first;
    } else {
      selectedSchedule = null;
    }
    print('schedule: $scheduleList');
    notifyListeners();
  }

  //  get added schedule
  Future<ScheduleModel> getAddedSchedule() async {
    if (date != null && time != null) {
      final List<Map<String, dynamic>> listMap =
          await ScheduleDBHelper.getAddedSchedule(date!, time!);

      if (listMap.isNotEmpty) {
        return ScheduleModel.fromMap(listMap.first);
      }
    }

    return ScheduleModel();

    // scheduleList = List.generate(
    //   listMap.length,
    //       (index) => ScheduleModel.fromMap(listMap[index]),
    // );
    // if (scheduleList.isNotEmpty) {
    //   selectedSchedule = scheduleList.first;
    // } else {
    //   selectedSchedule = null;
    // print('schedule: $scheduleList');
    //   // notifyListeners();
  }
}
