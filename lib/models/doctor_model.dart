const doctorTableName = 'doctor_table';

const doctorTableColId = 'doctor_id';
const doctorTableColName = 'doctor_name';
const doctorTableColMobile = 'doctor_mobile';
const doctorTableColEmail = 'doctor_email';
const doctorTableColPassword = 'doctor_password';
const doctorTableColImage = 'doctor_image';
const doctorTableColQualification = 'doctor_qualification';
const doctorTableColInstitute = 'doctor_institute';
const doctorTableColGender = 'doctor_gender';
const doctorTableColRating = 'doctor_rating';
const doctorTableColDescription = 'doctor_description';
const doctorTableColSpecialityId = 'speciality_id';
const doctorTableColIsAdmin = 'is_admin';

class DoctorModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? password;
  String? gender;
  String? institute;
  String? qualification;
  String? image;
  double? rating;
  String? description;
  int? specialityId;
  int? isAdmin;

  DoctorModel({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.password,
    this.gender,
    this.institute,
    this.qualification,
    this.image,
    this.rating,
    this.description,
    this.specialityId,
    this.isAdmin = 0,
  });


  @override
  String toString() {
    return 'DoctorModel{id: $id, name: $name, mobile: $mobile, email: $email password: $password, gender: $gender, address: $institute, qualification: $qualification, image: $image, description: $description, speciality: $specialityId}';
  }

  Map<String, dynamic> toMap() {
    return {
      doctorTableColId: id,
      doctorTableColName: name,
      doctorTableColGender: gender,
      doctorTableColMobile: mobile,
      doctorTableColEmail: email,
      doctorTableColPassword: password,
      doctorTableColQualification: qualification,
      doctorTableColInstitute: institute,
      doctorTableColImage: image,
      doctorTableColRating: rating,
      doctorTableColDescription: description,
      doctorTableColSpecialityId: specialityId,
      doctorTableColIsAdmin: isAdmin,

    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map[doctorTableColId],
      name: map[doctorTableColName],
      gender: map[doctorTableColGender],
      mobile: map[doctorTableColMobile],
      email: map[doctorTableColEmail],
      password: map[doctorTableColPassword],
      qualification: map[doctorTableColQualification],
      institute: map[doctorTableColInstitute],
      image: map[doctorTableColImage],
      rating: map[doctorTableColRating] ?? -99.0,
      description: map[doctorTableColDescription],
      specialityId: map[doctorTableColSpecialityId],
      isAdmin: map[doctorTableColIsAdmin],
    );
  }
}
