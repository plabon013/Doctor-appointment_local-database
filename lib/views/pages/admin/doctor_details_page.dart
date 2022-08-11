import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/models/hospital_model.dart';
import 'package:doctor_appointment/models/schedule_model.dart';
import 'package:doctor_appointment/providers/doc_schedule_provider.dart';
import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/providers/hospital_provider.dart';
import 'package:doctor_appointment/providers/schedule_provider.dart';
import 'package:doctor_appointment/views/pages/admin/add_doctor.dart';
import 'package:doctor_appointment/views/utils/layout/title_button_layout.dart';
import 'package:doctor_appointment/views/utils/widgets/appointment_date_time.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:doctor_appointment/views/utils/widgets/date_styled_widget.dart';
import 'package:doctor_appointment/views/utils/widgets/doctor_card_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoctorDetailsPage extends StatelessWidget {
  static const routeName = '/doctor_details';
  const DoctorDetailsPage({Key? key}) : super(key: key);

  final String text =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s''';

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
    // int doctorId = ModalRoute.of(context)!.settings.arguments as int;

    // DoctorProvider docProvider = Provider.of<DoctorProvider>(context,listen: false);
    // docProvider.findDoctorById(doctorId);
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          // statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
        title: const Text('Details'),
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
              Navigator.pushNamed(context, AddDoctor.routeName,
                  arguments: Provider.of<DoctorProvider>(context, listen: false)
                      .doctor);
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Save',
          ),
        ],
      ),
      body: ListView(
        children: [
          // doctor details card
          Consumer<DoctorProvider>(builder: (context, doctorProvider, child) {
            Provider.of<DocScheduleProvider>(context,listen: false).getDocScheduleDetails(doctorProvider.doctor?.id ?? -99);
            return DoctorCardOne(
              name: doctorProvider.doctor?.name ?? 'hi',
              specialityId: doctorProvider.doctor?.specialityId ?? -99,
              // specialist: 'Cardiology',
              institute: doctorProvider.doctor?.institute ?? 'institute',
              image: doctorProvider.doctor?.image,
              rating: doctorProvider.doctor?.rating ?? 0,
              isDetailsPage: true,
              doctorId: doctorProvider.doctor?.id ?? -99,
            );
          }),
          //doctor about section
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'About',
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<DoctorProvider>(
                  builder: (context, doctorProvider, child) => CustomText(
                    text: doctorProvider.doctor?.description ?? text,
                    isTitle: false,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // doctor schedule section =============================
          TitleButtonLayout(
            children: [
              CustomText(
                text: 'Schedule',
              ),
              IconButton(
                onPressed: () {
                  _createSchedule(context);
                },
                icon: const Icon(Icons.add),
                color: Colors.blue,
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    _updateSchedule(context, docScheduleProvider.commonModelList[index].docScheduleId!);
                    // print(docScheduleProvider.commonModelList[index].docScheduleId!);
                  },
                  onLongPress: () {
                    _deleteSchedule(context, docScheduleProvider.commonModelList[index].docScheduleId!);
                  },
                  child: AppointmentDateTime(
                    hospitalName: docScheduleProvider.commonModelList[index].hospitalName!,
                    hospitalAddress: docScheduleProvider.commonModelList[index].hospitalAddress!,
                    date: docScheduleProvider.commonModelList[index].scheduleDate!,
                    time: docScheduleProvider.commonModelList[index].scheduleTime!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createSchedule(BuildContext context) {
    alertDialog(
      context: context,
      title: 'Create Schedule',
      onPressOk: () async {
        HospitalModel selectedHospital =
            Provider.of<HospitalProvider>(context, listen: false)
                .selectedHospital!;
        ScheduleModel selectedSchedule =
            Provider.of<ScheduleProvider>(context, listen: false)
                .selectedSchedule!;
        DoctorModel doctor =
            Provider.of<DoctorProvider>(context, listen: false).doctor!;

        Provider.of<DocScheduleProvider>(context, listen: false)
            .insertDocSchedule(
          doctor.id!,
          selectedHospital.id!,
          selectedSchedule.id!,
        );

        print(selectedHospital);
        print(selectedSchedule);
        print(doctor);
        // print(addedScheduleModel);
        // print(hosProvider.selectedHospital);
        Navigator.pop(context);
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // hospital list
          Consumer<HospitalProvider>(
              builder: (context, hospitalProvider, child) {
            return hospitalProvider.selectedHospital != null
                ? DropdownButton<HospitalModel>(
                    borderRadius: BorderRadius.circular(20),
                    value: hospitalProvider.selectedHospital,
                    items: hospitalProvider.hospitalList
                        .map(
                          (hospitalModel) => DropdownMenuItem(
                            onTap: () {
                              print('tap on: ${hospitalModel.id}');
                            },
                            value: hospitalModel,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: hospitalModel.name!,
                                ),
                                CustomText(
                                  text: hospitalModel.address!,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      hospitalProvider.selectHospital(value!);
                      print(value);
                    },
                  )
                : CustomText(text: 'Hospital is not available');
          }),
          const SizedBox(
            height: 15,
          ),
          // schedule list
          Consumer<ScheduleProvider>(
              builder: (context, scheduleProvider, child) {
            return scheduleProvider.selectedSchedule != null
                ? DropdownButton<ScheduleModel>(
                    borderRadius: BorderRadius.circular(20),
                    value: scheduleProvider.selectedSchedule,
                    items: scheduleProvider.scheduleList
                        .map(
                          (scheduleModel) => DropdownMenuItem(
                            onTap: () {
                              print('tap on: ${scheduleModel.id}');
                            },
                            value: scheduleModel,
                            child: Row(
                              children: [
                                DateStyledWidget(
                                  title: scheduleModel.date!,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                DateStyledWidget(
                                  title: scheduleModel.time!,
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
                : CustomText(text: 'Schedule is not available');
          }),
        ],
      ),
    );
  }
  _updateSchedule(BuildContext context, int id) {
    alertDialog(
      context: context,
      title: 'Update Schedule',
      onPressOk: () async {
        HospitalModel selectedHospital =
        Provider.of<HospitalProvider>(context, listen: false)
            .selectedHospital!;
        ScheduleModel selectedSchedule =
        Provider.of<ScheduleProvider>(context, listen: false)
            .selectedSchedule!;
        DoctorModel doctor =
        Provider.of<DoctorProvider>(context, listen: false).doctor!;

        Provider.of<DocScheduleProvider>(context, listen: false).updateDocSchedule(
          doctor.id!,
          selectedHospital.id!,
          selectedSchedule.id!,
          id,
        );

        print(selectedHospital);
        print(selectedSchedule);
        print(doctor);
        print(id);
        Navigator.pop(context);

      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // hospital list
          Consumer<HospitalProvider>(
              builder: (context, hospitalProvider, child) {
            return hospitalProvider.selectedHospital != null
                ? DropdownButton<HospitalModel>(
                    borderRadius: BorderRadius.circular(20),
                    value: hospitalProvider.selectedHospital,
                    items: hospitalProvider.hospitalList
                        .map(
                          (hospitalModel) => DropdownMenuItem(
                            onTap: () {
                              print('tap on: ${hospitalModel.id}');
                            },
                            value: hospitalModel,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: hospitalModel.name!,
                                ),
                                CustomText(
                                  text: hospitalModel.address!,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      hospitalProvider.selectHospital(value!);
                      print(value);
                    },
                  )
                : CustomText(text: 'Hospital is not available');
          }),
          const SizedBox(
            height: 15,
          ),
          // schedule list
          Consumer<ScheduleProvider>(
              builder: (context, scheduleProvider, child) {
            return scheduleProvider.selectedSchedule != null
                ? DropdownButton<ScheduleModel>(
                    borderRadius: BorderRadius.circular(20),
                    value: scheduleProvider.selectedSchedule,
                    items: scheduleProvider.scheduleList
                        .map(
                          (scheduleModel) => DropdownMenuItem(
                            onTap: () {
                              print('tap on: ${scheduleModel.id}');
                            },
                            value: scheduleModel,
                            child: Row(
                              children: [
                                DateStyledWidget(
                                  title: scheduleModel.date!,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                DateStyledWidget(
                                  title: scheduleModel.time!,
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
                : CustomText(text: 'Schedule is not available');
          }),
        ],
      ),
    );
  } 
  
  _deleteSchedule(BuildContext context, int id) {
    alertDialog(
      context: context,
      title: 'Delete Schedule',
      onPressOk: () async {
        // HospitalModel selectedHospital =
        // Provider.of<HospitalProvider>(context, listen: false)
        //     .selectedHospital!;
        // ScheduleModel selectedSchedule =
        // Provider.of<ScheduleProvider>(context, listen: false)
        //     .selectedSchedule!;
        DoctorModel doctor =
        Provider.of<DoctorProvider>(context, listen: false).doctor!;

        Provider.of<DocScheduleProvider>(context, listen: false).deleteDocSchedule(doctor.id!, id);
        //
        // print(selectedHospital);
        // print(selectedSchedule);
        // print(doctor);
        // print(id);
        Navigator.pop(context);

      },
      content: CustomText(text: 'Confirm Delete?')
    );
  }
}
