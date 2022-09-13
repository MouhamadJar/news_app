import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController{




  Future<dynamic> setString({
    required String key,
    required String value,
  }) async {
    final sharedPreferencesController = await SharedPreferences.getInstance();
    return await sharedPreferencesController.setString(
      key,
      value,
    );
  }

  Future<dynamic> setInt({
    required String key,
    required int value,
  }) async {
    final sharedPreferencesController = await SharedPreferences.getInstance();
    return await sharedPreferencesController.setInt(
      key,
      value,
    );
  }

  Future<dynamic> getString({
    required String key,
  }) async {
    final sharedPreferencesController = await SharedPreferences.getInstance();
    return  sharedPreferencesController.getString(key);
  }

  Future<dynamic> getInt({
    required String key,
  }) async {
    final sharedPreferencesController = await SharedPreferences.getInstance();
    return  sharedPreferencesController.getInt(key);
  }

  Future<dynamic> removeData({
    required String key,
  }) async {
    final sharedPreferencesController = await SharedPreferences.getInstance();
    return await sharedPreferencesController.remove(key);
  }
}
