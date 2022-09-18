import 'dart:async';
import 'package:gif/gif.dart';
import 'package:get/get.dart  ';
import 'package:flutter/material.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:news_app/view/home/home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

late GifController controller;
  @override
  void initState() {
    super.initState();
    controller= GifController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child:  Gif(
          controller: controller,
          image: const AssetImage("assets/splash.gif"),
          onFetchCompleted: ()async {
            debugPrint('\nGIF Duration is :${controller.duration?.inMilliseconds}');
            Future.delayed( const Duration(milliseconds: 3750)).then((value) { Get.to(()=>HomeScreen(),);});
            await controller.forward();
           controller.reset();
          },
          fps: 30,
          fit: BoxFit.cover,
          autostart: Autostart.once,
          placeholder: (context) => const Text(''),
        ),
      ),
    );
  }
}
