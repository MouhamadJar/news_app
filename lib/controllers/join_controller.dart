import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import '../models/components/constants.dart';

class JoinController extends GetxController {
  RxBool isJoining = false.obs;
  APIController apiController = APIController();

  Future<dynamic> joinCompetition({
    required String body,
    required int id,
    required String youtubeLink,
  }) async {
    isJoining.value = true;
    update();
    var response = await apiController.dio.post(
      '/createPostCompetition',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        'body': body,
        'video': youtubeLink,
        'competition_id': id,
      },
    );
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
    isJoining.value = false;
    update();
  }
}
