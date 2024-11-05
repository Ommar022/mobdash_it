import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../color.dart';

class Utils {

  static bool _loaderShown = false;

  static void showCustomToast({
    required String msg,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: kLightSkyBlue,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void displayLoader() {
    if (_loaderShown) return;
    _loaderShown = true;
    Get.dialog(
      WillPopScope(
          child: const Center(
            child: CircularProgressIndicator(
              color: kLightSkyBlue,
            ),
          ),
          onWillPop: () async {
            _loaderShown = false;
            Get.back();
            Get.back();
            return false;
          }),
      barrierDismissible: false,
    );
  }

  static void hideLoader() {
    if (!_loaderShown) return;
    Get.back();
    _loaderShown = false;
  }


  static Future<String?> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      print('File selected: ${file.name}');
      return file.name;
    } else {
      print('No file selected');
      return null;
    }
  }


}
