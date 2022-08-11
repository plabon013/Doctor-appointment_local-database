import 'package:doctor_appointment/constents/toast.dart';
import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/providers/doctor_provider.dart';
import 'package:doctor_appointment/views/pages/admin/dashboard.dart';
import 'package:doctor_appointment/views/pages/doctor/doctor_home_page.dart';
import 'package:doctor_appointment/views/utils/auth/auth_prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/user/home_page.dart';

class LauncherPage extends StatefulWidget {
  static const routeName = '/auth_checking';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    getLoginStatus().then((value) async {
      print(value);
      if (value != null) {
        if (value > 0) {
          print('New value: $value');
          DoctorModel? doctorModel =
              await Provider.of<DoctorProvider>(context, listen: false)
                  .checkDoctorById(value);
          if (doctorModel?.isAdmin == 1) {

            Navigator.pushReplacementNamed(context, DashBoard.routeName);
          } else {
            Navigator.pushReplacementNamed(context, DoctorHomePage.routeName);
          }
        } else {
          print('returning home: $value');
          showToast('Welcome home');
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } else {
        print('returning home: $value');
        showToast('Welcome home');
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
