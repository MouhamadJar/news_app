import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextController extends GetxController {
  TextStyle getStyle({style}) => Get.locale == const Locale('ar', 'AE')
      ? GoogleFonts.cairo(
        textStyle: style,
      ) : GoogleFonts.notoSans(
    textStyle: style,
  );
}
