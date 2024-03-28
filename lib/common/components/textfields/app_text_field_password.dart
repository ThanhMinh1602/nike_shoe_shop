import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';

class AppTextFieldPassword extends StatefulWidget {
  const AppTextFieldPassword({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.fillColor = AppColor.whiteColor,
    this.boderRadius = 50.0,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Color? fillColor;
  final double? boderRadius;
  @override
  State<AppTextFieldPassword> createState() => _AppTextFieldEmailState();
}

class _AppTextFieldEmailState extends State<AppTextFieldPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      style: AppStyle.regular12,
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
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: Icon(_obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined)),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.boderRadius!.r),
          ),
        ),
      ),
    );
  }
}
