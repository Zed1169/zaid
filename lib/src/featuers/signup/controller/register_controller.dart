import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techbot/src/config/theme/theme.dart';
import 'package:techbot/src/core/model/user_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../core/backend/authentication/authentication.dart';
import '../../../core/backend/user_repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController major = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final updateKey = GlobalKey<FormState>();

  late UserModel user;
  final userRepository = Get.put(UserRepository);
  RxString selectedItem = "".obs;

  void registerUser(String email, String password) {
    AuthenticationRepository().createUserWithEmailAndPassword(email, password);
  }

  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '### ### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> createUser(UserModel user) async {
    await UserRepository().createUser(user);
    Get.to(Container());
  }

  validateEmail(String? email) {
    if (GetUtils.isEmail(email!)) {
      return null;
    }
    return 'Email is not vaild';
  }

  vaildPhoneNumber(String? phoneNumber) {
    if (GetUtils.isPhoneNumber(phoneNumber!)) {
      return null;
    }
    return 'Phone Number is not vaild';
  }

  vaildatePassword(String? password) {
    if (!GetUtils.isLengthGreaterOrEqual(password, 6)) {
      return 'Password is not vaild';
    }
    return null;
  }

  vaildFiled(dynamic text) {
    if (!GetUtils.isBlank(text!)!) {
      return null;
    }

    return 'The Major is not vild';
  }

  vaildateUserName(String? userName) {
    if (GetUtils.isUsername(userName!)) {
      return null;
    }
    return 'UserName is not vaild';
  }

  Future<void> onSignup(UserModel user) async {
    if (formkey.currentState!.validate()) {
      Future<bool> code = AuthenticationRepository()
          .createUserWithEmailAndPassword(user.email, user.password);
      if (await code) {
        createUser(user);
        Get.snackbar("Success", " Account  Created Successfullly",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.subappcolor,
            backgroundColor: AppColor.success);
      } else {
        Get.snackbar("ERROR", "Invalid datas",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppColor.subappcolor,
            backgroundColor: AppColor.error);
      }
    }
  }
}
