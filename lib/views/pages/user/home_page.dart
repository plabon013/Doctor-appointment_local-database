import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';
import 'package:doctor_appointment/models/specialities_model.dart';
import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/providers/hospital_provider.dart';
import 'package:doctor_appointment/providers/schedule_provider.dart';
import 'package:doctor_appointment/providers/specialities_provider.dart';
import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/pages/admin/doctor_list.dart';
import 'package:doctor_appointment/views/pages/admin/speciality_doctor.dart';
import 'package:doctor_appointment/views/pages/login_page.dart';
import 'package:doctor_appointment/views/pages/user/user_details_page.dart';
import 'package:doctor_appointment/views/pages/user/user_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/user/user_speciality_doctor_page.dart';
import 'package:doctor_appointment/views/utils/layout/card_list_layout.dart';
import 'package:doctor_appointment/views/utils/layout/title_button_layout.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_appbar.dart';
import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:doctor_appointment/views/utils/widgets/hospital_card_one.dart';
import 'package:doctor_appointment/views/utils/widgets/schedule_card.dart';
import 'package:doctor_appointment/views/utils/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/custom_text.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/doctor_card_two.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';
  const HomePage({Key? key}) : super(key: key);

  void alertDialog(
      {required BuildContext context,
      required String title,
      required VoidCallback onPressOk,
      required Widget content}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: CustomText(text: title),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomText(isTitle: false, text: 'CANCEL'),
          ),
          ElevatedButton(
            onPressed: onPressOk,
            child: CustomText(
              isTitle: false,
              color: Colors.white,
              text: 'OK',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const Text('DocTime'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline4?.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
            child: CustomText(
              text: 'Login',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // search bar
              const SearchBar(),
              const SizedBox(
                height: 25,
              ),
              // Specialities
              TitleButtonLayout(
                children: [
                  CustomText(
                    text: 'Specialities',
                    fontSize: 18,
                  ),
                ],
              ),
              CardListLayout(
                height: 60,
                child: Consumer<SpecialitiesProvider>(
                  builder: (context, specialityProvider, child) =>
                      ListView.builder(
                    itemCount: specialityProvider.specialitiesList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // _updateSpecialities(context, specialityProvider.specialitiesList[index]);
                        Navigator.pushNamed(
                          context,
                          UserSpecialityDoctor.routeName,
                          arguments:
                              specialityProvider.specialitiesList[index].id,
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Chip(
                          backgroundColor: Colors.white,
                          label: CustomText(
                            text: specialityProvider
                                .specialitiesList[index].name!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // doctors
              TitleButtonLayout(
                children: [
                  CustomText(
                    text: 'Doctors',
                    fontSize: 18,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, UserDoctorList.routeName);
                        },
                        child: CustomText(
                          text: 'See all',
                          color: Colors.blue,
                          isTitle: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CardListLayout(
                height: 430,
                child: Consumer<DoctorProvider>(
                  builder: (context, doctorProvider, child) => ListView.builder(
                    itemCount: doctorProvider.doctorList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          doctorProvider.setCurrentDoctor(
                              doctorProvider.doctorList[index]);
                          Navigator.pushNamed(
                            context,
                            UserDetailsPage.routeName,
                            arguments: doctorProvider.doctorList[index].id,
                          );
                        },
                        child: DoctorCardTwo(
                          specialityId:
                              doctorProvider.doctorList[index].specialityId ??
                                  -99,
                          name: doctorProvider.doctorList[index].name!,
                          institute:
                              doctorProvider.doctorList[index].institute!,
                          rating: doctorProvider.doctorList[index].rating!,
                          image: doctorProvider.doctorList[index].image,
                        )

                        // FutureBuilder<String>(
                        //   future: doctorProvider.getAllSpecialitiesOfDoctor(
                        //       doctorProvider.doctorList[index].id!),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasData) {
                        //       // String specialities =
                        //
                        //       return;
                        //     } else if (snapshot.hasError) {
                        //       return CustomText(
                        //         text: 'No data found',
                        //       );
                        //     } else {
                        //       return const CircularProgressIndicator();
                        //     }
                        //   }),
                        ),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              //hospital list
              TitleButtonLayout(
                children: [
                  CustomText(
                    text: 'Hospitals',
                    fontSize: 18,
                  ),
                ],
              ),
              CardListLayout(
                height: 100,
                child: Consumer<HospitalProvider>(
                  builder: (context, hospitalProvider, child) =>
                      ListView.builder(
                    itemCount: hospitalProvider.hospitalList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<DoctorProvider>(context, listen: false)
                              .getDoctorByHospitalId(
                              hospitalProvider.hospitalList[index].id!);
                          print(hospitalProvider.hospitalList[index].id);
                          Navigator.pushNamed(
                            context,
                            UserHospitalDoctorList.routeName,
                            arguments: hospitalProvider.hospitalList[index].id,
                          );
                        },
                        child: HospitalCardOne(
                          hospitalName:
                              hospitalProvider.hospitalList[index].name!,
                          hospitalAddress:
                              hospitalProvider.hospitalList[index].address!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addSpecialitiesButtonPress(BuildContext context) {
    // final docProvider = Provider.of<DoctorProvider>(context, listen: false);
    alertDialog(
      context: context,
      title: 'Add Speciality',
      onPressOk: () async {
        final bool isInserted =
            await Provider.of<SpecialitiesProvider>(context, listen: false)
                .insertSpecialities();
        if (isInserted) {
          showToast('Speciality successfully inserted');
          Navigator.pop(context);
        }
      },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            labelText: 'Speciality',
            onChanged: (value) {
              Provider.of<SpecialitiesProvider>(context, listen: false)
                  .specialityName = value;
            },
          ),
        ],
      ),
    );
  }

// _updateSpecialities(
//     BuildContext context, SpecialitiesModel specialitiesModel) {
//   alertDialog(
//     context: context,
//     title: 'Update Specialities',
//     onPressOk: () {
//       final specialityProvider =
//           Provider.of<SpecialitiesProvider>(context, listen: false);
//       // specialityProvider.findDoctorsBySpeciality(specialitiesModel);
//       // if (docProvider.selectedDoctor?.id != null) {
//       //   specialityProvider.insertSpecialities(docProvider.selectedDoctor);
//       // } else {
//       //   print('doctor id is null');
//       //   showToast('Create doctor first');
//       // }
//       //
//       // Navigator.pop(context);
//     },
//     content: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CustomText(text: 'Select Doctor'),
//         Consumer<SpecialitiesProvider>(
//             builder: (context, specialitiesProvider, child) {
//           return specialitiesProvider.selectedSpeciality != null
//               ? DropdownButton<DoctorModel>(
//                   borderRadius: BorderRadius.circular(20),
//                   value: specialitiesProvider.selectedSpeciality,
//                   items: specialitiesProvider.doctorListBySpecialities
//                       .map(
//                         (doctorModel) => DropdownMenuItem(
//                           onTap: () {
//                             print('tap on: ${doctorModel.id}');
//                           },
//                           value: doctorModel,
//                           child: CustomText(
//                             text: doctorModel.name!,
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) {
//                     specialitiesProvider.selectDoctor(value!);
//                     print(value);
//                   },
//                 )
//               : CustomText(text: 'No doctor available');
//         }),
//         const SizedBox(
//           height: 5,
//         ),
//         CustomTextField(
//           labelText: 'Speciality',
//           onChanged: (value) {
//             Provider.of<SpecialitiesProvider>(context, listen: false)
//                 .specialityName = value;
//           },
//         ),
//       ],
//     ),
//   );
// }
}
