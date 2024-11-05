import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mobdash_it/controller/post_controller.dart';
import 'package:mobdash_it/model/user_model.dart';
import 'package:mobdash_it/shared/service/webservice/auth_repository.dart';
import 'package:mobdash_it/view/home_screen.dart';
import 'package:mobdash_it/view/login.dart';
import '../shared/utils/utils.dart';

class UserController extends GetxController
{
  final user = Rxn<UserModel>();
  final _isLoading = RxBool(false);

  final PostController _postController = Get.put(PostController(), tag: 'postController');

  Future<void> login({
    required final String email,
    required final String password,
  }) async {
    if (email.isEmpty) {
      Utils.showCustomToast(msg: 'please_fill_email'.tr);
      return;
    }
    if (password.isEmpty) {
      Utils.showCustomToast(msg: 'please_fill_password'.tr);
      return;
    }

    _isLoading(true);
    try {
      final response = await AuthRepository().login(email: email, password: password);
      _isLoading(false);

      if (response != null) {
        user(response);
        _postController.getPosts(postType: 'software');
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => const HomeScreen());

        if (kDebugMode) {
          print('User successfully logged in');
          print('User data: ${response}');
        }

      }
      else {
        Utils.showCustomToast(msg: 'Login failed'.tr);
      }
    } catch (e) {
      _isLoading(false);
      Utils.showCustomToast(msg: 'User does not exist'.tr);
    }
  }
  Future<void> register({
    required final String username,
    required final String email,
    required final String phone,
    required final String password,
    // required final String confirmPassword,
}) async{
    if(username.isEmpty){
        Utils.showCustomToast(msg: 'please_fill_username'.tr);
        return;
      }
    if(email.isEmpty){
      Utils.showCustomToast(msg: 'please_fill_email'.tr);
      return;
    }
    if(phone.isEmpty){
      Utils.showCustomToast(msg: 'please_fill_phone'.tr);
      return;
    }
    if(password.isEmpty){
      Utils.showCustomToast(msg: 'please_fill_password'.tr);
      return;
    }
    // if(confirmPassword.isEmpty){
    //   Utils.showCustomToast(msg: 'please_fill_confirm_Password');
    //   return;
    // }
    // if(password != confirmPassword){
    //     Utils.showCustomToast(msg: 'Password_and_confirm_password_do_not_match'.tr);
    //     return;
    //   }
    _isLoading(true);
    final result = AuthRepository().register(username: username, email: email, phone: phone, password: password, );
    _isLoading(false);
    if(result != null)
      {
        // user(result);
        Get.to(() => const LoginPage());
      }
  }
  bool get isLoading => _isLoading.value;

}