import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/home_controller.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';

import '../models/ResearchModel.dart';
import 'text_controller.dart';

class ResearchController extends GetxController {
  RxBool isLoadingResearches = true.obs;
  RxBool isAddingResearches = false.obs;
  var homeController = Get.put(HomeController());
  var apiController = Get.put(APIController());
  var textController = Get.put(TextController());
  RxList images = [].obs ;
  List<ResearchModel> researches = [];

  Future getResearches() async {
    var response = await apiController.getAllResearches();
    print(response.data.toString());
    researches.clear();
    for (var research in response.data['data']) {
      researches.add(ResearchModel.fromJson(research));
    }
    isLoadingResearches.value = false;
    update();
  }

  Future<dynamic> createResearch({
    required String youtubeLink,
    required String title,
    required String body,
    required List images,
  }) async {
    isAddingResearches.value = true;
    update();
    var response = await apiController.createResearch(
        youtubeLink: youtubeLink, title: title, body: body, images: images);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Done'.tr,
          'the order sent successfully to the admin , please wait '.tr,
          backgroundColor: Colors.green.withOpacity(0.6));
      print('response is : ${response.data}');
    } else if (response.statusCode! > 299) {
      Get.snackbar('ops'.tr, 'Connection error'.tr,
          backgroundColor: Colors.red.withOpacity(0.6));
      print('response is : ${response.data}');
    }
    isAddingResearches.value = false;
    update();
  }

  @override
  void onInit() {
    getResearches();
    super.onInit();
  }
}
