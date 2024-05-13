import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:techbot/src/config/theme/theme.dart';
import 'package:techbot/src/core/backend/user_repository/user_repository.dart';
import 'package:techbot/src/core/controller/user_controller.dart';
import 'package:techbot/src/core/model/form_model.dart';
import 'package:techbot/src/core/widget/buttons/buttons.dart';
import 'package:techbot/src/core/widget/froms/form_model.dart';
import 'package:techbot/src/core/widget/text/text.dart';
import 'package:techbot/src/featuers/login/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void clearText() {
    controller.email.clear();
    controller.password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.mainAppColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                TextApp.mainAppText('Let’s Login.!'),
                Form(
                  key: controller.formkey,
                  child: SizedBox(
                    height: 450,
                    width: double.infinity,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      children: [
                        FormWidget(
                            textForm: FormModel(
                                controller: controller.email,
                                enableText: false,
                                hintText: "Email",
                                icon: const Icon(Icons.email),
                                invisible: false,
                                validator: (email) =>
                                    controller.validateEmail(email),
                                type: TextInputType.emailAddress,
                                onChange: null,
                                inputFormat: [],
                                onTap: null)),
                        const Gap(15),
                        FormWidget(
                            textForm: FormModel(
                                controller: controller.password,
                                enableText: false,
                                hintText: "Password",
                                icon: const Icon(Icons.password),
                                invisible: true,
                                validator: (password) =>
                                    controller.vaildatePassword(password),
                                type: TextInputType.visiblePassword,
                                onChange: null,
                                inputFormat: [],
                                onTap: null)),
                        const Gap(15),
                        Buttons.formscontainer(
                            title: 'Login',
                            onTap: () => {
                                  controller.onLogin(),
                                  UserRepository()
                                      .getUserDetails(controller.email.text),
                                  UserController().logIn()
                                }),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                RichText(
                  text: TextSpan(
                    text: 'dont have have an account? ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(Container());
                          },
                        text: 'Sign Up',
                        style: TextStyle(
                          color: AppColor.mainAppColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
