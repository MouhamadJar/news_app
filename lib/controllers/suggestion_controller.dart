import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';

class SuggestionController extends GetxController {
  RxBool isSendingRequest = false.obs;
  APIController apiController = APIController();

  Future<dynamic> sendRequest({
    required String name,
    required int age,
    required String job,
    required String suggestionType,
    required String jobType,
    required String country,
    required File file,
    required int phoneNumber,
    required String email,
  }) async {
    isSendingRequest.value = true;
    update();
    var response = await apiController.createSuggestion(
        name: name,
        age: age,
        job: job,
        suggestionType: suggestionType,
        jobType: jobType,
        country: country,
        file: file,
        phoneNumber: phoneNumber,
        email: email);

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
    isSendingRequest.value = false;
    update();
  }
}
