import 'dart:io';

import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/doctor_model.dart';
import '../../../models/specialities_model.dart';
import '../../../providers/specialities_provider.dart';
import '../../utils/widgets/custom_icon_button.dart';
import '../../utils/widgets/custom_text.dart';
import '../../utils/widgets/custom_text_field.dart';

class AppointmentPage extends StatelessWidget {
  static const routeName = '/appointment_page';
  const AppointmentPage({Key? key}) : super(key: key);

  void _picImageOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: CustomText(text: 'Select one'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIconButton(
              title: 'Camera',
              icon: Icons.camera,
              onPressed: () {
                Provider.of<DoctorProvider>(context, listen: false)
                    .pickImageWithCamera();
                Navigator.pop(context);
              },
            ),
            CustomIconButton(
              title: 'Gallery',
              icon: Icons.image,
              onPressed: () {
                Provider.of<DoctorProvider>(context, listen: false)
                    .pickImageWithGallery();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DoctorModel doctorModel = ModalRoute.of(context)!.settings.arguments as DoctorModel;
    // final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    print(doctorModel);
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: Text( doctorModel.id != null? 'Update Doctor' : 'Add Doctor'),
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
          IconButton(
            onPressed: () async {


            },
            icon: const Icon(Icons.save),
            tooltip: 'Save',
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                // name
                CustomTextField(
                  labelText: 'Name',
                  onChanged: (value) {
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                // Mobile number
                CustomTextField(
                  labelText: 'Mobile Number',
                  onChanged: (value) {
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                //Email
                CustomTextField(
                  labelText: 'Email',
                  onChanged: (value) {
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //Qualification
                CustomTextField(
                  labelText: 'Qualification',
                  onChanged: (value) {
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //Institute
                CustomTextField(
                  labelText: 'Institute',
                  onChanged: (value) {
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Description',
                  onChanged: (value) {
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(text: 'Select speciality'),
                      const SizedBox(width: 15,),
                      Consumer<SpecialitiesProvider>(
                          builder: (context, specialitiesProvider, child) {
                            print(specialitiesProvider.selectedSpeciality);
                            Provider.of<DoctorProvider>(context, listen: false).specialityName = specialitiesProvider.selectedSpeciality?.name;
                            print(Provider.of<DoctorProvider>(context, listen: false).specialityName);
                            return specialitiesProvider.selectedSpeciality != null
                                ? DropdownButton<SpecialitiesModel>(
                              borderRadius: BorderRadius.circular(20),
                              value: specialitiesProvider.selectedSpeciality,
                              items: specialitiesProvider.specialitiesList
                                  .map(
                                    (specialitiesModel) => DropdownMenuItem(
                                  onTap: () {
                                    print('tap on: ${specialitiesModel.id}');
                                  },
                                  value: specialitiesModel,
                                  child: CustomText(
                                    text: specialitiesModel.name!,
                                  ),
                                ),
                              )
                                  .toList(),
                              onChanged: (value) {
                                specialitiesProvider.selectSpeciality(value!);
                                Provider.of<DoctorProvider>(context, listen: false).specialityName = value.name;
                                print(value);
                              },
                            )
                                : CustomText(text: 'Unavailable');
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //======== gender input field =========
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Select Gender',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Consumer<DoctorProvider>(
                                    builder: (context, doctorProvider, child) =>
                                        Radio<String>(
                                          value: 'male',
                                          groupValue: doctorProvider.gender,
                                          onChanged: (value) {
                                            doctorProvider.selectGender(value!);
                                          },
                                        ),
                                  ),
                                  const Text('Male'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Consumer<DoctorProvider>(
                                    builder: (context, doctorProvider, child) =>
                                        Radio<String>(
                                          value: 'female',
                                          groupValue: doctorProvider.gender,
                                          onChanged: (value) {
                                            doctorProvider.selectGender(value!);
                                          },
                                        ),
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                // Save button
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith<
                            RoundedRectangleBorder>((states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          );
                        }),
                      ),
                      onPressed: () {
                        // doctorProvider.printDocInfo();
                        print('save button pressed');
                      },
                      child: CustomText(
                        text: 'Save',
                        isTitle: false,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
