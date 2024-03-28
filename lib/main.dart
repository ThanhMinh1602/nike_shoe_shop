import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_dashboard/presentations/page/admin_dashboard_page.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/presentations/page/admin_login_page.dart';
import 'package:nike_shoe_shop/features/user/splash/presentations/page/splash_page.dart';
import 'package:nike_shoe_shop/services/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';

void main() async {
  _initialService();
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
    Widget initialPage;
    Size size;

    if (kIsWeb) {
      initialPage = const AdminDashboardPage();
      // AdminLoginPage();
      size = const Size(1440, 1024);
    } else {
      initialPage = const SplashPage();
      size = const Size(275, 812);
    }

    return ScreenUtilInit(
      designSize: size,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(colorSchemeSeed: AppColor.primaryColor),
          debugShowCheckedModeBanner: false,
          title: 'sneacker_shop',
          home: initialPage,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
