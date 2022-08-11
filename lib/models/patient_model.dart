const patientTableName = 'patient_table';

const patientTableColId= 'patient_id';
const patientTableColName = 'patient_name';
const patientTableColAddress = 'patient_address';
const patientTableColMobile = 'patient_mobile';
const patientTableColEmail = 'patient_email';

class PatientModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? address;

  PatientModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.address,
  });


  @override
  String toString() {
    return 'PatientModel{patientId: $id, patientName: $name, patientMobile: $mobile, patientEmail: $email, patientAddress: $address}';
  }

  Map<String, dynamic> toMap() {
    return {
      patientTableColId: id,
       patientTableColName:  name,
      patientTableColMobile: mobile,
      patientTableColEmail: email,
      patientTableColAddress: address,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map[patientTableColId],
      name: map[patientTableColName],
      mobile: map[patientTableColMobile],
      email: map[patientTableColEmail],
      address: map[patientTableColAddress],
    );
  }

}
