import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/shared/local/shared_preferences_controller.dart';
import 'package:news_app/models/UserModel.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:news_app/view/home/home_screen.dart';
import 'network_controllers/api_controller.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  APIController apiController = Get.put(APIController());
  SharedPreferencesController sharedPreferencesController =
      Get.put(SharedPreferencesController());

  Future<dynamic> injectProfileData() async {
    var response = await apiController.getProfile();
    user = UserModel.fromJson(response.data['data']);
  }

  Future<dynamic> userLogin({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    update();
    try {
      var response =
          await apiController.login(email: email, password: password);
      isLoading.value = false;
      update();
      Get.snackbar(
        'Done'.tr,
        'Login Successfully'.tr,
      );
      await sharedPreferencesController.setString(
          key: 'token', value: response.data.toString());
      token = response.data.toString();
      await injectProfileData();
      Get.to(() => HomeScreen());
    } catch (error) {
      isLoading.value = false;
      update();
      Get.snackbar('ops'.tr, 'Login Failed'.tr,
          backgroundColor: Colors.redAccent.withOpacity(0.4));
    }
  }

  Future<dynamic> userSignup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    isLoading.value = true;
    update();
    try {
      var response = await apiController.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      isLoading.value = false;
      update();
      Get.snackbar(
        'Done'.tr,
        'Signup Successfully'.tr,
      );

      await sharedPreferencesController.setString(
          key: 'token', value: response.data.toString());
      token = response.data.toString();
      await injectProfileData();
      Get.to(() => HomeScreen());
    } catch (error) {
      isLoading.value = false;
      update();
      Get.snackbar('ops'.tr, 'Signup Failed'.tr,
          backgroundColor: Colors.redAccent.withOpacity(0.4));
    }
  }

  Future<void> injectToken() async {
    token =
        await sharedPreferencesController.getString(key: 'token') ?? 'noToken';
  }
}
