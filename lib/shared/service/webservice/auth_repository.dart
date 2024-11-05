import 'dart:convert';
import 'dart:developer';

import 'package:mobdash_it/shared/service/webservice/web_service.dart';

import '../../../model/user_model.dart';
import '../../utils/utils.dart';

class AuthRepository extends WebService {


  Future<UserModel?> login({
    required final String email,
    required final String password,
  }) async {
    try {
      final response = await post(
        action: 'login',
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response == null) {
        log('Response is null');
        return null;
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status_code'] != '0') {
        Utils.showCustomToast(msg: jsonResponse['desc']);
        return null;
      }

      // if (jsonResponse['status_code'] == -1 || jsonResponse['status_code'] == '-1') {
      //   Utils.showCustomToast(msg: jsonResponse['desc']);
      //   return null;
      // }

      final data = jsonResponse['data'];
      if (data == null || data.isEmpty) {
        log('Data is null or empty in JSON response');
        return null;
      }

      final userModel = UserModel.fromJson(data);
      log('UserModel created: ${userModel.toString()}');

      return userModel;
    } catch (e, stacktrace) {
      log('Exception occurred in login method: $e');
      log('Stacktrace: $stacktrace');
      return null;
    }
  }

Future<Map<String , dynamic>?> register ({
    required String username,
    required String email,
    required String phone,
    required String password,
    // required String confirmPassword,
}) async {
    final response = await post(action: 'register', body: {
      'username' : username,
      'email' : email,
      'phone_number' : phone,
      'password' : password,
      // 'confirmPassword' : confirmPassword,
    });

    if(response == null)
      {
        return null;
      }
    final jsonResponse = jsonDecode(response.body);
    if(jsonResponse == null)
      {
        return null;
      }
    else
      {
        return jsonResponse['data'];
      }
}
}