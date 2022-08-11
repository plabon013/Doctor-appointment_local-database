const String scheduleTableName = 'schedule_table';
const String scheduleTableColId = 'schedule_id';
const String scheduleTableColDate = 'schedule_date';
const String scheduleTableColTime = 'schedule_time';

class ScheduleModel {
  int? id;
  String? date;
  String? time;

  ScheduleModel({
    this.id,
    this.date,
    this.time,
  });


  @override
  String toString() {
    return 'ScheduleModel{id: $id, date: $date, time: $time}';
  }

  Map<String, dynamic> toMap() {
    return {
      scheduleTableColId: id,
      scheduleTableColDate: date,
      scheduleTableColTime: time,
    };
  }

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map[scheduleTableColId],
      date: map[scheduleTableColDate],
      time: map[scheduleTableColTime],
    );
  }
}
