import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';

class AppTextFieldEmail extends StatelessWidget {
  const AppTextFieldEmail({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
  });
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontSize: 8.sp,
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 16.0),
        filled: true,
        fillColor: AppColor.whiteColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
      ),
    );
  }
}
