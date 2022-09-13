import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/view/home/sport_news/news_details.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';
import 'ifmis_news_details.dart';

class IfmisCategoryNews extends StatelessWidget {
  IfmisCategoryNews({Key? key}) : super(key: key);
  var searchController = TextEditingController();

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
            Hero(
              tag: 'ifmis',
              child: Container(
                height: (Get.height * .05),
                width: (Get.width * .1),
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
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .02, vertical: height * .015),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
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
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => IfmisNewsDetails(
                      tag: 'tag',
                      title: 'News title',
                      image: 'assets/news.png',
                    ),
                  );
                },
                child: Hero(
                  tag: 'tag',
                  child: Container(
                    height: height * .23,
                    width: width,
                    padding: EdgeInsets.only(bottom: height * .057),
                    margin: EdgeInsets.symmetric(
                        horizontal: width * .02, vertical: height * .01),
                    decoration: BoxDecoration(
                      color: kGrey,
                      borderRadius: BorderRadius.circular(7.6),
                      image: const DecorationImage(
                          image: AssetImage('assets/news.png'),
                          fit: BoxFit.cover),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height * .03,
                      width: width,
                      color: Colors.transparent,
                      child: Center(
                          child: showText(
                              text: 'News title'.tr,
                              textColor: kWhite,
                              size: 16)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .26,
                width: width,
                child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(
                        () => IfmisNewsDetails(
                          tag: 'tag $index',
                          title: 'News title',
                          image: 'assets/news.png',
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'tag $index',
                      child: Container(
                        height: height * .23,
                        width: width * .4,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * .02, vertical: height * .015),
                        padding: EdgeInsets.only(bottom: height * 0.065),
                        decoration: BoxDecoration(
                          color: kGrey,
                          borderRadius: BorderRadius.circular(5.6),
                          image: const DecorationImage(
                              image: AssetImage('assets/news.png'),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: height * .03,
                          width: width,
                          color: Colors.transparent,
                          child: Center(
                              child: showText(
                                  text: 'News title'.tr,
                                  textColor: kWhite,
                                  size: 16)),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    width: width * .01,
                  ),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: height * .025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * .001,
                    width: width * .3,
                    color: kGrey,
                  ),
                  SizedBox(
                    width: width * .065,
                  ),
                  showText(text: 'LatestNews'.tr, textColor: kGrey, size: 16.0),
                  SizedBox(
                    width: width * .065,
                  ),
                  Container(
                    height: height * .001,
                    width: width * .3,
                    color: kGrey,
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                width: width,
                height: height * .12 * 7,
                child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.to(
                        () => IfmisNewsDetails(
                          tag: 'tag $index 1',
                          title: 'News title',
                          image: 'assets/news.png',
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * .02),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                              color: kGrey,
                              blurRadius: 5,
                              offset: Offset(0, 1)),
                        ],
                      ),
                      height: height * .1,
                      width: width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'tag $index 1',
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kGrey,
                                  borderRadius: BorderRadius.circular(5),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/news.png'),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  )),
                              height: height * .09,
                              width: width * .15,
                            ),
                          ),
                          SizedBox(
                            width: width * .035,
                          ),
                          showText(
                              text: 'News title'.tr,
                              textColor: kBlack,
                              size: 16.0),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: height * .015,
                  ),
                  itemCount: 7,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
