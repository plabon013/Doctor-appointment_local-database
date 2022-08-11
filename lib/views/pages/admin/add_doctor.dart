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

class AddDoctor extends StatelessWidget {
  static const routeName = '/create_doctor';
  const AddDoctor({Key? key}) : super(key: key);

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
    DoctorModel? updateDoctorModel;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      updateDoctorModel =
          ModalRoute.of(context)!.settings.arguments as DoctorModel;
    } else {
      updateDoctorModel = null;
    }
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    print(updateDoctorModel);

    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: Text(
            updateDoctorModel?.id != null ? 'Update Doctor' : 'Add Doctor'),
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
              if (updateDoctorModel?.id != null) {
                print('update');
                bool isInserted =
                    await doctorProvider.updateDoctor(updateDoctorModel!);
                if (isInserted) {
                  Navigator.pop(context);
                }
              } else {
                print('insert');
                bool isInserted = await doctorProvider.insertDoctor();
                if (isInserted) {
                  Navigator.pop(context);
                }
              }
            },
            icon: const Icon(Icons.save),
            tooltip: 'Save',
          ),
        ],
      ),
      body: ListView(
        children: [
          //======== image input field =========
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Consumer<DoctorProvider>(
                    builder: (context, doctorProvder, child) =>
                        doctorProvder.imagePath != null
                            ? Image.file(
                                File(doctorProvider.imagePath!),
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'images/img.jfif',
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () {
                      _picImageOption(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white60,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),

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
                    doctorProvider.name = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                // Mobile number
                CustomTextField(
                  labelText: 'Mobile Number',
                  onChanged: (value) {
                    doctorProvider.mobile = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                //Email
                CustomTextField(
                  labelText: 'Email',
                  onChanged: (value) {
                    doctorProvider.email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                //password
                CustomTextField(
                  labelText: 'Password',
                  onChanged: (value) {
                    doctorProvider.password = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //Qualification
                CustomTextField(
                  labelText: 'Qualification',
                  onChanged: (value) {
                    doctorProvider.qualification = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                //Institute
                CustomTextField(
                  labelText: 'Institute',
                  onChanged: (value) {
                    doctorProvider.institute = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Description',
                  onChanged: (value) {
                    doctorProvider.description = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Speciality'),
                      const SizedBox(
                        height: 15,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Consumer<SpecialitiesProvider>(
                            builder: (context, specialitiesProvider, child) {

                          return specialitiesProvider.selectedSpeciality != null
                              ? DropdownButton<SpecialitiesModel>(
                                  borderRadius: BorderRadius.circular(20),
                                  value: specialitiesProvider.selectedSpeciality,
                                  items: specialitiesProvider.specialitiesList
                                      .map(
                                        (specialitiesModel) => DropdownMenuItem(
                                          onTap: () {
                                            print(
                                                'tap on: ${specialitiesModel.id}');
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
                                    Provider.of<DoctorProvider>(context,
                                            listen: false)
                                        .specialityName = value.name;
                                    print(value);
                                  },
                                )
                              : CustomText(text: 'Unavailable');
                        }),
                      ),
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

                Row(
                  children: [
                    CustomText(text: 'Set admin'),
                    Consumer<DoctorProvider>(
                      builder: (context, doctorProvider, child) => Checkbox(
                        value: doctorProvider.admin,
                        onChanged: (value) {
                          doctorProvider.setAdmin(value!);
                        },
                      ),
                    ),
                  ],
                ),
                // Save button
                // Center(
                //   child: SizedBox(
                //     width: 150,
                //     height: 45,
                //     child: ElevatedButton(
                //       style: ButtonStyle(
                //         shape: MaterialStateProperty.resolveWith<
                //             RoundedRectangleBorder>((states) {
                //           return RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20),
                //           );
                //         }),
                //       ),
                //       onPressed: () {
                //         // doctorProvider.printDocInfo();
                //         print('save button pressed');
                //       },
                //       child: CustomText(
                //         text: 'Save',
                //         isTitle: false,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
