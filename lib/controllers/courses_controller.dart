import 'package:dio/src/response.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/models/CourseModel.dart';

import 'home_controller.dart';

class CoursesController extends GetxController {
  var apiController = Get.put(APIController());
  var homeController = Get.put(HomeController());
  RxBool isLoadingCourses = true.obs;

  List<CourseModel> freeCourses =[];

  Future<dynamic> getFreeCourses()async{
    var response = await apiController.getCourses();
    response.data['data'].forEach((course){
      freeCourses.add(CourseModel.fromJson(course));
    });
    isLoadingCourses.value = false ;
    update();
  }

Future<dynamic> getLessons ({required int id})async {
   var response = await apiController.getCourseLessons(id: id);
   return response;
}

  @override
  void onInit() {
    getFreeCourses();
    super.onInit();
  }
}