import 'package:flutter_easyloading/flutter_easyloading.dart';

void showToast(String message){
  EasyLoading.showToast(
    message,
    duration: const Duration(milliseconds: 1000),
    toastPosition: EasyLoadingToastPosition.bottom,
  );
}