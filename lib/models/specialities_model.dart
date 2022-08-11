const String specialitiesTableName = 'specialities_table';
const String specialitiesTableColId = 'specialities_id';
const String specialitiesTableColName = 'specialities_name';

class SpecialitiesModel {
  int? id;
  String? name;

  SpecialitiesModel({
    this.id,
    this.name
  });

  @override
  String toString() {
    return 'SpecialitiesModel{id: $id, name: $name}';
  }

  Map<String, dynamic> toMap() {
    return {
      specialitiesTableColId: id,
      specialitiesTableColName: name,
    };
  }

  factory SpecialitiesModel.fromMap(Map<String, dynamic> map) {
    return SpecialitiesModel(
      id: map[specialitiesTableColId],
      name: map[specialitiesTableColName],
    );
  }
}
