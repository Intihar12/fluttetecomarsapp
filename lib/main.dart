import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/auth/splash.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/styles.dart';
import 'data/dependencing_injection/data_binding.dart';
import 'data/notification/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseNotifications.instance.initLocalNotification();
  FirebaseNotifications.instance.generateNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: MyColors.black, // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icon color
        systemNavigationBarIconBrightness: Brightness.dark,
      ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Styles.appTheme,
      getPages: [
        GetPage<void>(
            name: '/', page: () => SplashScreen(), binding: DataDependency()),
      ],
    );
  }
}
