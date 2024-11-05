import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdash_it/controller/user_controller.dart';
import 'package:mobdash_it/shared/color.dart';
import 'package:mobdash_it/shared/index.dart';
import 'package:mobdash_it/view/signup.dart';
import '../shared/utils/my_custoum_button.dart';
import '../shared/utils/text_filed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _user = Get.put(UserController(),tag: 'userController');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:  const EdgeInsets.all(kPadding),
                child: Center(
                  child: Column (
                    children: [
                      const SizedBox(height: kPadding * 5,),
                      Text('welcome_back'.tr,style: const TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: kBlack),textAlign: TextAlign.center,),
                      Text('enter_credentials'.tr,style: const TextStyle(fontSize: 16,color: kBlack),textAlign: TextAlign.center,),
                      const SizedBox(height: kPadding * 3.5,),
                      MyTextFiled(hintText: 'email'.tr, textFiledType: 'email', controller: _emailController,),
                      const SizedBox(height: kPadding / 2,),
                      MyTextFiled(textFiledType: 'password' , hintText: 'password'.tr, obscureText: true,controller: _passwordController,),
                      const SizedBox(height: kPadding ,),
                      MyCustomButton(onPressed: () {
                        _user.login(email: _emailController.text, password: _passwordController.text);
                      },
                        text: 'login'.tr,
                        fontSize: 30,
                        height: 80,
                        radius: kRadius * 3,
                        backgroundColor: kRquoise,),
                      const SizedBox(height: kPadding * 5 ,),
                      GestureDetector(
                        onTap: () {},
                          child: Text('forgot_password'.tr,
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kRquoise),
                            textAlign: TextAlign.center,),
                      ),
                      const SizedBox(height: kPadding * 5 ,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('do_you_have_account'.tr,
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kBlack),
                            textAlign: TextAlign.center,),
                          const SizedBox(width: kPadding / 2,),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SignUpPage());
                            },
                            child: Text('signup'.tr,
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
