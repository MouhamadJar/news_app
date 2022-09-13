import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/models/sport_matches_apis_model/MatchModel.dart';

class SportController extends GetxController {
  APIController apiController = Get.put(APIController());
  RxBool isLoadingMatches = true.obs;
  List<MatchModel> matches = [];
  Rx<DateTime> day = DateTime.now().obs;

  dynamic getDayMatches() async {
    isLoadingMatches.value = true;
    update();
    try {
      var response = await apiController.getDayMatches(
          date: '${day.value.year}-${day.value.month}-${day.value.day}');
      matches.clear();
      response.data.forEach((match) {
        matches.add(MatchModel.fromJson(match));
      });
    } catch (e) {
      print(e.toString());
      Get.snackbar('ops'.tr, 'Connection Error'.tr,
          backgroundColor: Colors.red.withOpacity(0.5));
    }

    isLoadingMatches.value = false;
    update();
  }

  dynamic addOneDay() async {
    day.value = day.value.add(const Duration(days: 1));
    print(day.value.toString());
    await getDayMatches();
  }

  dynamic removeOneDay() async {
    day.value = day.value.add(const Duration(days: -1));
    print(day.value.toString());
    await getDayMatches();
  }
}

class MatchDetailsController extends GetxController {
  RxInt currentIndex = 0.obs;

  dynamic changePage({required int newIndex}) {
    currentIndex.value = newIndex;
    update();
  }
}
