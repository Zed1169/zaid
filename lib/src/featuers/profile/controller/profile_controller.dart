
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techbot/src/core/backend/authentication/authentication.dart';
import 'package:techbot/src/core/controller/user_controller.dart';
import 'package:techbot/src/featuers/profile/model/profile_button_model.dart';

class ProfileController extends GetxController {
  List<ProfileButton> profileList = [
    ProfileButton(
        title: 'My chats',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () =>
            Get.to(const Scaffold(), transition: Transition.rightToLeft)),
    ProfileButton(
        title: 'my schulde',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () =>
            Get.to(const Scaffold(), transition: Transition.rightToLeft)),
    ProfileButton(
        title: 'About',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15,
          height: 15,
        ),
        onTap: () {}),
    ProfileButton(
      title: 'Logout',
      icon: SvgPicture.asset(
        'assets/arrow.svg',
        matchTextDirection: true,
        width: 15,
        height: 15,
      ),
      onTap: () => {
        AuthenticationRepository().logout(),
        UserController.instance.clearUserInfo()
      },
    ),
  ];
}
