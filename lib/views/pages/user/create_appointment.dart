import 'dart:io';

import 'package:doctor_appointment/models/common_model.dart';
import 'package:doctor_appointment/providers/appointment_provider.dart';
import 'package:doctor_appointment/providers/doc_schedule_provider.dart';
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

class CreateAppointment extends StatelessWidget {
  static const routeName = '/create_appointment';
  const CreateAppointment({Key? key}) : super(key: key);

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
    DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context,listen: false);
    Provider.of<DocScheduleProvider>(context,listen: false).getDocScheduleDetails(doctorProvider.doctor?.id ?? -99);
    AppointmentProvider appointmentProvider = Provider.of<AppointmentProvider>(context,listen: false);
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const Text('Create Appointment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        titleTextStyle: Theme.of(context).textTheme.headline4?.copyWith(
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CustomText(text: 'Appointment for'),
                const SizedBox(width: 20,),
                CustomText(text: doctorProvider.doctor?.name ?? ''),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<DocScheduleProvider>(
              builder: (context, scheduleProvider, child) {
                return scheduleProvider.selectedSchedule != null
                    ? DropdownButton<CommonModel>(
                  borderRadius: BorderRadius.circular(20),
                  value: scheduleProvider.selectedSchedule,
                  items: scheduleProvider.commonModelList
                      .map(
                        (commonModel) => DropdownMenuItem(
                      onTap: () {
                        print('tap on: ${commonModel.scheduleId}');
                      },
                      value: commonModel,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            text: commonModel.hospitalName!,
                          ),
                          CustomText(
                            text: commonModel.scheduleDate!,
                          ),
                          CustomText(
                            text: commonModel.scheduleTime!,
                          ),
                        ],
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    scheduleProvider.selectSchedule(value!);
                    print(value);
                  },
                )
                    : CustomText(text: 'Hospital is not available');
              }),

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
                    appointmentProvider.name = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
                // Mobile number
                CustomTextField(
                  labelText: 'Mobile Number',
                  onChanged: (value) {
                    appointmentProvider.mobile = value;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                //Email
                CustomTextField(
                  labelText: 'Email',
                  onChanged: (value) {
                    appointmentProvider.email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //Qualification
                CustomTextField(
                  labelText: 'Address',
                  onChanged: (value) {
                    appointmentProvider.address = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      onPressed: () async {
                        // print(Provider.of<DocScheduleProvider>(context,listen: false).selectedSchedule?.docScheduleId);
                        // print(Provider.of<DocScheduleProvider>(context,listen: false).selectedSchedule);
                        bool isOk = await appointmentProvider.insertAppointment(Provider.of<DocScheduleProvider>(context,listen: false).selectedSchedule?.docScheduleId);
                        if (isOk){
                          Navigator.pop(context);
                        }
                      },
                      child: CustomText(
                        text: 'Appointment',
                        isTitle: false,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
