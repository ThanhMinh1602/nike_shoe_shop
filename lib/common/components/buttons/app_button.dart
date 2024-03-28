import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      this.onPressed,
      this.buttonText,
      this.boderRadius = 50.0,
      this.minimumSize});
  final void Function()? onPressed;
  final String? buttonText;
  final double boderRadius;
  final Size? minimumSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize,
        textStyle: AppStyle.regular14,
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(boderRadius.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.h),
      ),
      child: Text(
        buttonText ?? '',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
