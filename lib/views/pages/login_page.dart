import 'package:doctor_appointment/models/doctor_model.dart';
import 'package:doctor_appointment/providers/user_handler_provider.dart';
import 'package:doctor_appointment/views/utils/auth/launcher_page.dart';
import 'package:doctor_appointment/views/utils/auth/auth_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constents/toast.dart';
import '../../providers/doctor_provider.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserHandlerProvider userHandlerProvider =
        Provider.of<UserHandlerProvider>(context, listen: false);
    return Scaffold(
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
      ),
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(left: 35, top: 80),
          child: const Text(
            "Welcome\nBack",
            style: TextStyle(color: Colors.black, fontSize: 33),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 35,
                left: 35,
                top: MediaQuery.of(context).size.height * 0.3),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  userHandlerProvider.email = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  userHandlerProvider.password = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Color(0xff4c505b),
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xff4c505b),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () async {
                        print(userHandlerProvider.email);
                        print(userHandlerProvider.password);
                        if (userHandlerProvider.email != null &&
                            userHandlerProvider.password != null) {
                          DoctorModel doctorModel =
                              await Provider.of<DoctorProvider>(context,
                                      listen: false)
                                  .checkLogin(userHandlerProvider.email!,
                                      userHandlerProvider.password!);
                          print(doctorModel);
                          if (doctorModel.id != null) {
                            setLoginStatus(doctorModel.id!).then((value) =>
                                Navigator.pushReplacementNamed(
                                    context, LauncherPage.routeName));
                          } else {
                            showToast('Email or Password not matched');
                          }
                        }
                      },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
