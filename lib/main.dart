import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/features/splash/presentations/page/splash_page.dart';
import 'package:nike_shoe_shop/services/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';

void main() async {
  await _initialService();
  runApp(const MyApp());
}

Future<void> _initialService() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialise();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(275, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(colorSchemeSeed: AppColor.primaryColor),
          debugShowCheckedModeBanner: false,
          title: 'sneacker_shop',
          // home: const AdHomePage(),
          home: const SplashPage(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
