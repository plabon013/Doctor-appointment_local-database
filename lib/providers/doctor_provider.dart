import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/db/database_helper.dart';
import 'package:doctor_appointment/db/doc_schedule_db_helper.dart';
import 'package:doctor_appointment/db/doctor_db_helper.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/specialities_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../db/specialities_db_helper.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> doctorList = [];
  List<DoctorModel> doctorListBySpecialities = [];
  List<DoctorModel> doctorInHospitalList = [];
  DoctorModel? selectedDoctor;
  DoctorModel? doctor;
  DoctorModel? loginDoctor;

  // ===================== doctor info =====================
  String? name;
  String? mobile;
  String? email;
  String? imagePath;
  String? qualification;
  String? institute;
  String? dateOfBirth;
  String? gender;
  double? rating;
  String? description;
  String? password;

  String? specialityName;
  bool admin = false;

  DoctorModel? loggedUser;

  // image picking
  ImageSource imageSource = ImageSource.camera;
  void pickImageWithCamera() {
    imageSource = ImageSource.camera;
    _selectImage();
  }

  void pickImageWithGallery() {
    imageSource = ImageSource.gallery;
    _selectImage();
  }

  void _selectImage() async {
    final image = await ImagePicker().pickImage(source: imageSource);
    imagePath = image!.path;
    notifyListeners();
  }

  //select gender
  void selectGender(String value) {
    gender = value;
    notifyListeners();
  }

  setCurrentDoctor(DoctorModel doctorModel){
    doctor = doctorModel;
    notifyListeners();
  }

  // set admin
  setAdmin(bool value){
    admin = value;
    notifyListeners();
  }

  // ===================== specialities info =====================
  void selectDoctor(DoctorModel _selectedDoctor) {
    selectedDoctor = _selectedDoctor;
    notifyListeners();
  }

//  =============== Doctor database operation ================
  // Insert doctor into doctor table
  Future<bool> insertDoctor() async {
    SpecialitiesModel specialitiesModel = await findSpecialityByName(specialityName);
    DoctorModel doctorModel = DoctorModel(
      name: name,
      mobile: mobile,
      email: email,
      password: password,
      gender: gender,
      institute: institute,
      qualification: qualification,
      image: imagePath,
      rating: 0.0,
      specialityId: specialitiesModel.id,
      isAdmin: admin == true ? 1: 0,
    );

    DoctorModel doctor = await findDoctorByEmail(doctorModel.email!);
    if (doctor.id != null) {
      showToast('Doctor is already present');
      return false;
    } else {

      int rowId = await DoctorDBHelper.insertDoctor(doctorModel);
      if (rowId > 0) {
        // doctorList.add(doctorModel);

        imagePath = null;
        gender = null;
        // selectedDoctor = doctorList.first;
        showToast('Doctor successfully added');
        getAllDoctor();
        return true;
      } else {
        showToast('Failed to add Doctor');
        return false;
      }
    }
  }

  // update doctor
   Future<bool> updateDoctor(DoctorModel previousDoctorModel) async {
    SpecialitiesModel specialitiesModel = await findSpecialityByName(specialityName);
    DoctorModel updatedDoctorModel = DoctorModel(
      id: previousDoctorModel.id,
      name: name ?? previousDoctorModel.name,
      mobile: mobile ?? previousDoctorModel.mobile,
      email: email ?? previousDoctorModel.email,
      qualification: qualification ?? previousDoctorModel.qualification,
      institute: institute ?? previousDoctorModel.institute,
      description: description ?? previousDoctorModel.description,
      specialityId: specialitiesModel.id ?? previousDoctorModel.specialityId,
      gender: gender ?? previousDoctorModel.gender,
    );

    int rowId = await DoctorDBHelper.updateDoctor(updatedDoctorModel);
    if (rowId > 0) {
      // doctorList.add(doctorModel);

      imagePath = null;
      gender = null;
      // selectedDoctor = doctorList.first;
      showToast('Doctor successfully added');
      getAllDoctor();
      findDoctorById(previousDoctorModel.id!);
      return true;
    } else {
      showToast('Failed to add Doctor');
      return false;
    }


  }

//  get all doctor
  getAllDoctor() async {
    final List<Map<String, dynamic>> listMap =
        await DoctorDBHelper.getAllDoctor();

    doctorList = List.generate(
      listMap.length,
      (index) => DoctorModel.fromMap(listMap[index]),
    );
    print('docList: $doctorList');
    if (doctorList.isNotEmpty) {
      selectedDoctor = doctorList.first;
    } else {
      selectedDoctor = null;
    }
    notifyListeners();
  }

//  delete doctor by id
  deleteDoctorById(int id) async {
    int rowId = await DoctorDBHelper.deleteDoctorById(id);
    if (rowId > 0) {
      showToast('Doctor Deleted');
      getAllDoctor();
    }
  }

//  find doctor by email
  Future<DoctorModel> findDoctorByEmail(String email) async {
    final List<Map<String, dynamic>> listMap =
    await DoctorDBHelper.findDoctorByEmail(email);
    if (listMap.isNotEmpty) {
      return DoctorModel.fromMap(listMap.first);
    } else {
      return DoctorModel();
    }
  }

  //  find doctor by email
  Future<DoctorModel> checkLogin(String email, String password) async {
    final List<Map<String, dynamic>> listMap =
    await DoctorDBHelper.checkLogin(email, password);
    if (listMap.isNotEmpty) {
      return DoctorModel.fromMap(listMap.first);
    } else {
      return DoctorModel();
    }
  }
  //  find doctor by id
    findDoctorById(int id) async {
    final List<Map<String, dynamic>> listMap =
    await DoctorDBHelper.findDoctorById(id);
    if (listMap.isNotEmpty) {
      doctor = DoctorModel.fromMap(listMap.first);
      notifyListeners();
    }
  }
  //  find doctor by id
    Future<DoctorModel?> checkDoctorById(int id) async {
    final List<Map<String, dynamic>> listMap =
    await DoctorDBHelper.findDoctorById(id);
    if (listMap.isNotEmpty) {

      loginDoctor = DoctorModel.fromMap(listMap.first);
      notifyListeners();
      return loginDoctor;
    }
    notifyListeners();
    return DoctorModel();
  }


/*============ speciality query ================*/
  // find doctor by name
  Future<SpecialitiesModel> findSpecialityByName(String? name) async {
    if (name != null){
      final List<Map<String, dynamic>> listMap =
      await SpecialitiesDBHelper.findSpecialityByName(name);
      if (listMap.isNotEmpty) {
        return SpecialitiesModel.fromMap(listMap.first);
      }
    }
    return SpecialitiesModel();
  }



//  get speciality of a doctor
  Future <String> getSpecialityOfDoctor(int specialityId) async {
    final List<Map<String, dynamic>> listMap = await DoctorDBHelper.getAllSpecialitiesOfDoctor(specialityId);
    return List.generate(listMap.length, (index) => listMap[index][specialitiesTableColName]).join(', ');
    // List.generate(listMap.length, (index) => listMap[index]['name']).join(', ');
  }

  // find doctor by speciality
  findDoctorsBySpeciality(int _specialityId) async {
    print('special: $_specialityId');
    List<Map<String, dynamic>> listMap =
    await SpecialitiesDBHelper.findDoctorsBySpeciality(_specialityId);
    doctorListBySpecialities = List.generate(
      listMap.length,
          (index) => DoctorModel.fromMap(listMap[index]),
    );

    print(doctorListBySpecialities);
    notifyListeners();
  }

  // get doctor by hospital id
  getDoctorByHospitalId(
      int id) async {
    final listMap = await DocScheduleDBHelper.getDoctorByHopitalId(id);
    doctorInHospitalList  = List.generate(listMap.length, (index) => DoctorModel.fromMap(listMap[index]));
    print(doctorInHospitalList);
    notifyListeners();
  }
}
