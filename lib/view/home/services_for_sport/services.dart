import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/models/components/map.dart';
import 'package:news_app/view/home/services_for_sport/service_detailes.dart';
import 'package:news_app/view/home/stores/store_products.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class Services extends StatelessWidget {
  Services({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    var homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        toolbarHeight: Get.height * .215,
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
              width: Get.width * .185,
            ),
            Hero(
              tag: 'ifmis',
              child: Container(
                height: (Get.height * .09),
                width: (Get.width * .15),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                  ),
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
        flexibleSpace: FittedBox(
          child: Column(
            children: [
              SizedBox(height: height*.185,),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 2.0),
                height: height * .05,
                width: width,
                child: Center(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      fillColor: kWhite,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Search'.tr,
                      labelStyle: Get.locale == const Locale('ar', 'AE')
                          ? GoogleFonts.ibmPlexSansArabic(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: kGrey,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                          : GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: kGrey,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      suffixIcon: const Icon(Iconsax.search_normal_1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: ListView.separated(
          itemBuilder: (context, index) => OpenContainer(
            closedElevation: 0,
            closedBuilder: (context,action)=>Container(
              margin: EdgeInsets.symmetric(horizontal: width*.045,vertical: height*.01),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(5),
                boxShadow:const [
                  BoxShadow(
                      color: kGrey,
                      blurRadius: 5,
                      offset: Offset(0  , 1)
                  ),
                ],
              ),
              height: height * .09,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: kGrey,
                            borderRadius: BorderRadius.circular(7.6),
                            image: const DecorationImage(
                              image: AssetImage('assets/Football services.jpg'),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            )),
                        height: height * .07,
                        width: width * .13,
                      ),
                      SizedBox(
                        width: width * .035,
                      ),
                      showText(
                          text: 'Service name'.tr, textColor: kBlack, size: 16.0),
                    ],
                  ),
                ],
              ),
            ),
            openBuilder: (context,action)=>ServiceDetails(tag: 'tag $index', title: 'Service name', image: 'assets/services1.png'),
            transitionDuration: const Duration(milliseconds: 500),
            transitionType: ContainerTransitionType.fadeThrough,
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: height * .03,
          ),
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
