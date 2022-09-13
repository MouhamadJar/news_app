import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/competition_controller.dart';
import 'package:news_app/view/home/competition/competition_details.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class Competitions extends StatelessWidget {
  Competitions({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    var competitionController = Get.put(CompetitionController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          toolbarHeight: Get.height * .215,
          flexibleSpace: Container(
            width: width,
            height: height * .205,
            alignment: Alignment.bottomCenter,
            child: Container(
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
          ),
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
                  height: (Get.height * .07),
                  width: (Get.width * .12),
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
        body: Obx(() => competitionController.isLoadingCompetitions.value
            ? myLoader()
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) =>competitionController.competitions.isEmpty? Center(child: showText(text: 'No competition yet'))  :
                  OpenContainer(
                    openBuilder: (context, action)=>CompetitionDetails(
                      id: competitionController.competitions[index].id,
                      image: imageURL +
                          competitionController
                              .competitions[index].images.first.src,
                    ) ,
                    closedBuilder: (context , action) => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * .025, vertical: height * .01),
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
                      height: height * .09,
                      width: width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: kGrey,
                                    borderRadius: BorderRadius.circular(7.6),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        imageURL +
                                            competitionController
                                                .competitions[index]
                                                .images
                                                .first
                                                .src,
                                      ),
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    )),
                                height: height * .07,
                                width: width * .13,
                              ),
                              SizedBox(
                                width: width * .035,
                              ),
                              SizedBox(
                                width: Get.width*.6,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: showText(
                                      text: competitionController
                                          .competitions[index].name,
                                      textColor: kBlack,
                                      size: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                    closedElevation: 0,
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 350),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: height * .03,
                  ),
                  itemCount:competitionController.competitions.isEmpty ? 1 : competitionController.competitions.length,
                  physics: const BouncingScrollPhysics(),
                ),
              )),
      ),
    );
  }
}
