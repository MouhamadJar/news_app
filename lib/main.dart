import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/controllers/home_controller.dart';
import 'package:news_app/controllers/language_controller.dart';
import 'package:news_app/view/auth/splash_screen.dart';
import 'controllers/dictionary.dart';
import 'models/components/constants.dart';
import 'dart:io';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await LanguageController().injectLanguage();
  await AuthController().injectToken();
  await HomeController().injectHomeData();
  token == 'noToken' ? null : await AuthController().injectProfileData();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageController = Get.put(LanguageController());

    return GetMaterialApp(
      onInit: () async {
        print('\n token is : $token');
        print('\n language is : $language');
      },
      translations: Dictionary(),
      locale: languageController.getLanguage(),
      fallbackLocale: const Locale('ar', 'AE'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        shadowColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
        ),
        floatingActionButtonTheme:const FloatingActionButtonThemeData(
          backgroundColor: kPrimaryColor,
        )
      ),
      title: 'News App',
      onDispose: (){print('\nDisposed');},

      home: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
