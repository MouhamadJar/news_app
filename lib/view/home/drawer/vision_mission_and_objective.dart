import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controllers/home_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:readmore/readmore.dart';

import '../../../models/components/constants.dart';

class VisionMissionAndObjective extends StatelessWidget {
  const VisionMissionAndObjective({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

       return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColorWithDarkness,
        elevation: 5,
        title: Row(
          children: [
            SizedBox(
              width: width * .19,
            ),
            Hero(
              tag: 'ifmis',
              child: Container(
                height: (height * .05),
                width: (width * .1),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * .01,
            ),
            showText(
              text: 'IFMIS',
              textColor: kWhite,
              size: 24.0,
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: height * .073,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.015),
        child: Column(
          children: [
            Container(
              height: (height * .21),
              width: (width * .32),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: width,
              height: height*.015,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                vision,
                trimLines: 10,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                moreStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                style: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


