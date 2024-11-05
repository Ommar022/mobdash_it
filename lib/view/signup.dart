import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdash_it/controller/user_controller.dart';
import 'package:mobdash_it/shared/color.dart';
import 'package:mobdash_it/shared/index.dart';
import 'package:mobdash_it/shared/utils/my_custoum_button.dart';
import 'package:mobdash_it/shared/utils/text_filed.dart';
import 'package:mobdash_it/view/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _user = Get.put(UserController() , tag: 'userController');
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: kPadding * 5,),
                      Text('signup'.tr,style: const TextStyle(fontSize: 45,fontWeight: FontWeight.bold ,color: kBlack),),
                      Text('create_account'.tr,style: const TextStyle(fontSize: 18, color: kBlack),),
                      const SizedBox(height: kPadding * 3.5,),
                      MyTextFiled(textFiledType: 'username',hintText: 'username'.tr, controller: _usernameController,),
                      const SizedBox(height: kPadding / 2,),
                      MyTextFiled(textFiledType: 'email' ,hintText: 'email'.tr, controller: _emailController,),
                      const SizedBox(height: kPadding / 2,),
                      MyTextFiled(textFiledType: 'phone number' ,hintText: 'phone_number'.tr, controller: _phoneController,),
                      const SizedBox(height: kPadding / 2,),
                      MyTextFiled(textFiledType: 'password' ,hintText: 'password'.tr, obscureText: true, controller: _passwordController,),
                      const SizedBox(height: kPadding / 2,),
                      // MyTextFiled(textFiledType: 'password' ,hintText: 'confirm_password'.tr, obscureText: true, controller: _confirmPasswordController,),
                      // const SizedBox(height: kPadding / 2,),
                      MyCustomButton(
                          onPressed: (){
                            // Get.offAll(() => HomeScreen());
                            _user.register(username: _usernameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                password: _passwordController.text,
                                // confirmPassword: _confirmPasswordController.text
                            );
                          },
                          text: 'signup'.tr,
                          fontSize: 30,
                          height: 80,
                          radius: kRadius * 3,
                          backgroundColor: kRquoise),
                      const SizedBox(height: kPadding * 2.5 ,),
                      Text('or'.tr),
                      const SizedBox(height: kPadding * 2.5 ,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('already_have_account'.tr,
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kBlack),
                            textAlign: TextAlign.center,),
                          const SizedBox(width: kPadding / 2,),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginPage());
                            },
                            child: Text('login'.tr,
                              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kRquoise),
                              textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
