const docScheduleTableName = 'doc_schedule_table';

const docScheduleTableColId = 'doc_schedule_id';
const docScheduleTableColDoctorId = 'doctor_id';
const docScheduleTableColScheduleId = 'schedule_id';
const docScheduleTableColHospitalId = 'hospital_id';

class DocScheduleModel {
  int? id;
  int? doctorId;
  int? scheduleId;
  int? hospitalId;

  DocScheduleModel({
    this.id,
    this.doctorId,
    this.scheduleId,
    this.hospitalId,
  });


  @override
  String toString() {
    return 'DocScheduleModel{docScheduleId: $id, doctorId: $doctorId, scheduleId: $scheduleId, hospitalId: $hospitalId}';
  }

  Map<String, dynamic> toMap() {
    return {
      docScheduleTableColId: id,
      docScheduleTableColDoctorId: doctorId,
      docScheduleTableColScheduleId: scheduleId,
     docScheduleTableColHospitalId: hospitalId,
    };
  }

  factory DocScheduleModel.fromMap(Map<String, dynamic> map) {
    return DocScheduleModel(
      id: map[docScheduleTableColId],
      doctorId: map[docScheduleTableColDoctorId],
      scheduleId: map[docScheduleTableColScheduleId],
      hospitalId: map[docScheduleTableColHospitalId],
    );
  }

}
