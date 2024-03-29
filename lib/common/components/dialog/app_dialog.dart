import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';

class AppDiaLog {
  static void showAwesomeDialog(BuildContext context,
      {String? content,
      void Function()? btnOkOnPress,
      void Function()? btnCancelOnPress}) {
    AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      dialogBorderRadius: BorderRadius.circular(20.0),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      headerAnimationLoop: true,
      showCloseIcon: false,
      desc: content,
      dialogType: DialogType.noHeader,
      descTextStyle: AppStyle.regular18,
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress != null ? () {} : null,
    ).show();
  }
}
