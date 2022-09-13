import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class StoreProducts extends StatelessWidget {
  const StoreProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    var homeController = Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: Container(
        height: height * .1,
        width: width,
        color: kPrimaryColor,
        child: PhysicalModel(
          color: Colors.grey.withOpacity(0.05),
          elevation: 5.0,
          child: CarouselSlider(
            items: sliderData.map((element) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * .03,
                ),
                width: width,
                height: height * .15,
                child: GestureDetector(
                  onTap: () {
                    // Get.to(
                    //       () => PhoneSpecs(
                    //     phone: element,
                    //   ),
                    // );
                  },
                  child: Image.network(
                    element,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: height * .15,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 750),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        //toolbarHeight: Get.height * .15,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAll(
                () => HomeScreen(),
              );
            },
            icon: const Icon(Icons.home_rounded),
          ),
        ],
        title: Row(
          children: [
            SizedBox(
              width: Get.width * .19,
            ),
            Container(
              height: (Get.height * .05),
              width: (Get.width * .1),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: Get.width * .01,
            ),
            showText(
              text: 'IFMIS',
              textColor: kWhite,
              size: 24.0,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(
                Uri.parse('https://ifmis-2030.shop'),
              )) {
                launchUrl(Uri.parse('https://ifmis-2030.shop'),
                    webViewConfiguration:const WebViewConfiguration(
                      enableJavaScript: true,
                      enableDomStorage: true,
                    ),
                mode:  LaunchMode.inAppWebView
                );
              } else if (!await canLaunchUrl(
                Uri.parse('https://ifmis-2030.shop'),
              )) {
                Get.snackbar(
                  'Ops...'.tr,
                  'Internet connection error'.tr,
                );
              }
            },
            child: Container(
              height: height * .2,
              width: width,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(7.6),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: kGrey,
                        borderRadius: BorderRadius.circular(7.6),
                        image: const DecorationImage(
                          image: AssetImage('assets/store.png'),
                          fit: BoxFit.cover,
                        )),
                    height: height * .18,
                    width: width * .3,
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      showText(
                          text: 'Store name'.tr, textColor: kBlack, size: 16),
                      SizedBox(
                        height: height * .03,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: height * .017,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
        ),
      ),
    );
  }
}
