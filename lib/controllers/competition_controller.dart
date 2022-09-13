import 'package:get/get.dart';
import '../models/CompetitionModel.dart';
import 'home_controller.dart';
import 'network_controllers/api_controller.dart';

class CompetitionController extends GetxController {
  var apiController = Get.put(APIController());
  var homeController = Get.put(HomeController());
  RxBool isLoadingCompetitions = true.obs;

  List<CompetitionModel> competitions = [];

  Future<dynamic> getCompetitions() async {
    var response = await apiController.getAllCompetitions().then((value) {
      print(value.data['data'].toString());
      for (var competition in value.data['data']) {
        competitions.add(CompetitionModel.fromJson(competition));
      }
      isLoadingCompetitions.value = false;
      update();
    }).catchError((onError) {
      print(onError.toString());
      isLoadingCompetitions.value = false;
      update();
    });
  }

  @override
  void onInit() {
    getCompetitions();
    super.onInit();
  }
}
