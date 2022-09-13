import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/models/components/constants.dart';

class HomeController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  var apiController = Get.put(APIController());

  Future<void> injectHomeData() async {
    var response = await apiController.getBannerImage();
    response.data.forEach((bannerLink) {
      sliderData.add('$imageURL/${bannerLink['image']}');
      print(sliderData.length.toString());
    });
    response = await apiController.getIFMISMembers();
    response.data['data'].forEach((member) {
      ifmisMembersImages.add(member['imageProfile']);
      ifmisMembersCountry.add(member['country']);
      ifmisMembersNames.add(member['name']);
      ifmisMembersSpecialization.add(member['jop']);
      ifmisMembersFlag.add(member['imageFlag']);
      print(member.toString());
    });

    response = await apiController.getBreakingNews();
    response.data.forEach((news) {
      newsSliderData = '$newsSliderData $news      |  ';
    });

    response = await apiController.getSiteInfo();
    vision = response.data['data'][0]['value'];
    privacyPolicy = response.data['data'][1]['value'];
    conditionsForObtainingMembership = response.data['data'][2]['value'];
    intellectualPropertyRights = response.data['data'][3]['value'];
    evacuationResponsibility = response.data['data'][4]['value'];

    response = await apiController.getContactusInfo();
    contactusEmail = response.data['email'];
    contactusPhone = response.data['phone'];

    response = await apiController.getAppVisitorNumber();
    appVisitorNumber = response.data['Count'].toString();

    response = await apiController.addAppVisitor();
  }

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}
