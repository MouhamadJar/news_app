import 'dart:io';

import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';

class ProfileController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isNewImage = false.obs;
  Rx<File> image = File('').obs ;
  var apiController = Get.put(APIController());


  void updateImage (File newImage) {
    image.value = newImage;
    isNewImage.value = true;
    update();
  }
}