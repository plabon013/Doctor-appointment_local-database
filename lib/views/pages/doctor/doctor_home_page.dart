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
import 'package:doctor_appointment/views/pages/admin/hospital_doctor_list.dart';
import 'package:doctor_appointment/views/pages/admin/speciality_doctor.dart';
import 'package:doctor_appointment/views/utils/auth/auth_prefs.dart';
import 'package:doctor_appointment/views/utils/layout/card_list_layout.dart';
import 'package:doctor_appointment/views/utils/layout/title_button_layout.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_appbar.dart';
import 'package:doctor_appointment/views/utils/widgets/date_time_widget.dart';
import 'package:doctor_appointment/views/utils/widgets/hospital_card_one.dart';
import 'package:doctor_appointment/views/utils/widgets/schedule_card.dart';
import 'package:doctor_appointment/views/utils/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../providers/doc_schedule_provider.dart';
import '../../utils/widgets/appointment_date_time.dart';
import '../../utils/widgets/custom_text.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../../utils/widgets/doctor_card_two.dart';
import '../admin/doctor_details_page.dart';

class DoctorHomePage extends StatelessWidget {
  static const routeName = '/doctor_home_page';
  const DoctorHomePage({Key? key}) : super(key: key);

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
    getLoginStatus().then((value) async {
      await Provider.of<DoctorProvider>(context, listen: false)
          .findDoctorById(value!);
      // print(Provider.of<DoctorProvider>(context, listen: false).doctor);
    });
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              //app bar
              Consumer<DoctorProvider>(
                builder: (context, value, child) => CustomAppBar(
                  name: value.doctor?.name ?? '',
                  image: value.doctor?.image ?? '',
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              TitleButtonLayout(
                children: [
                  CustomText(
                    text: 'Schedule',
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Consumer<DocScheduleProvider>(
                  builder: (context, docScheduleProvider, child) =>  ListView.builder(
                    itemCount: docScheduleProvider.commonModelList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => AppointmentDateTime(
                      hospitalName: docScheduleProvider.commonModelList[index].hospitalName!,
                      hospitalAddress: docScheduleProvider.commonModelList[index].hospitalAddress!,
                      date: docScheduleProvider.commonModelList[index].scheduleDate!,
                      time: docScheduleProvider.commonModelList[index].scheduleTime!,
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
