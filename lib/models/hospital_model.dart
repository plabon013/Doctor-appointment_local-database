const String hospitalTableName = 'hospital_table';
const String hospitalTableColId = 'hospital_id';
const String hospitalTableColName = 'hospital_name';
const String hospitalTableColAddress = 'hospital_address';

class HospitalModel {
  int? id;
  String? name;
  String? address;

  HospitalModel({
    this.id,
    this.name,
    this.address,
  });

  @override
  String toString() {
    return 'HospitalModel{id: $id, name: $name, address: $address}';
  }

  Map<String, dynamic> toMap() {
    return {
      hospitalTableColId: id,
      hospitalTableColName: name,
      hospitalTableColAddress: address,
    };
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      id: map[hospitalTableColId],
      name: map[hospitalTableColName],
      address: map[hospitalTableColAddress],
    );
  }
}
