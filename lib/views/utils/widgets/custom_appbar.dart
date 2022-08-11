import 'dart:io';

import 'package:doctor_appointment/views/utils/auth/auth_prefs.dart';
import 'package:doctor_appointment/views/utils/auth/launcher_page.dart';
import 'package:doctor_appointment/views/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String image;
  final String name;
  const CustomAppBar({
    required this.image,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: image.isEmpty
              ? Image.asset(
                  'images/img.jfif',
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                )
              : Image.file(
                  File(image),
                  fit: BoxFit.cover,
                  height: 200,
                  width: 200,
                ),
        ),
      ),
      title: CustomText(text: name),
      subtitle: CustomText(text: 'How is your health'),
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: CustomText(
                text: 'Logout',
              ),
              onTap: () {
                setLoginStatus(-99).then(
                  (value) => Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName),
                );
              },
            ),
          ];
        },
      ),
      // leading: ,
    );
  }
}
