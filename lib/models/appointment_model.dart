const appointmentTableName = 'appointment_table';

const appointmentTableColId = 'appointment_id';
const appointmentTableColDocScheduleId = 'doc_schedule_id';
const appointmentTableColPatientId = 'patient_id';
const appointmentTableColSerialNumber = 'serial_number';

class AppointmentModel {
  int? id;
  int? docScheduleId;
  int? patientId;

  AppointmentModel({
    this.id,
    this.docScheduleId,
    this.patientId,
  });


  @override
  String toString() {
    return 'AppointmentModel{id: $id, docScheduleId: $docScheduleId, patientId: $patientId}';
  }

  Map<String, dynamic> toMap() {
    return {
      appointmentTableColId: id,
      appointmentTableColDocScheduleId: docScheduleId,
      appointmentTableColPatientId: patientId,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map[appointmentTableColId],
      docScheduleId: map[appointmentTableColDocScheduleId],
      patientId: map[appointmentTableColPatientId],
    );
  }
}
