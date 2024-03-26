import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';

class AppStyle {
  AppStyle._();
  static TextStyle regula28 = GoogleFonts.acme(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regula14 = GoogleFonts.acme(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle medium28 = GoogleFonts.acme(
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle loginTitle = GoogleFonts.abel(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle loginSubTitle = GoogleFonts.aBeeZee(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
  );
  static TextStyle regular10 = GoogleFonts.aBeeZee(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regular12 = GoogleFonts.aBeeZee(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regular8 = GoogleFonts.aBeeZee(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle regular14 = GoogleFonts.aBeeZee(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle nameProductStyle = GoogleFonts.aBeeZee(
    fontSize: 14.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bold16 = GoogleFonts.aBeeZee(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle categoryStyle = GoogleFonts.aBeeZee(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
  );
}
