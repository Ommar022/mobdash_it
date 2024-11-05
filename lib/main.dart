import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'controller/post_controller.dart';
import 'controller/user_controller.dart';

void main() {
  Get.put(UserController(), tag: 'userController');
  Get.put(PostController(), tag: 'postController');
  runApp(const MyApp());
}



