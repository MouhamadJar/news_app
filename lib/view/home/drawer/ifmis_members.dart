import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/view/home/competition/competition_details.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../comming_soon.dart';
import '../home_screen.dart';

class IfmisMembers extends StatelessWidget {
  const IfmisMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    var homeController = Get.put(HomeController());
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
        padding: EdgeInsets.symmetric(
            horizontal: width * .02, vertical: height * .012),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      height: height*.35,
                      padding: EdgeInsets.symmetric(horizontal: width*.012,vertical: height*.01),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: height * .13,
                                  width: width * .25,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        ifmisMembersImages[index],
                                      ),
                                    ),
                                    shape: CircleBorder(),
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: width * .02),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SizedBox(
                                    height: height*.03,
                                    width: width*.07,
                                    child:Image.network(ifmisMembersFlag[index]) ,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width,
                              height: height*.015,
                            ),
                            showText(
                              text: ifmisMembersNames[index],
                              textColor: kWhite,
                              size: 12,
                            ),
                            SizedBox(
                              width: width,
                              height: height*.012,
                            ),
                            Center(
                              child: showText(
                                text: ifmisMembersSpecialization[index],
                                textColor: kWhite,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              width: width,
                              height: height*.012,
                            ),
                            showText(
                              text: ifmisMembersCountry[index],
                              textColor: kWhite,
                              size: 12,
                            ),
                            SizedBox(
                              width: width,
                              height: height*.012,
                            ),
                          ],
                        ),
                      ),
                    ),
                    shape: CircleBorder(),

                  );
                },
                child: Container(
                  height: height * .09,
                  width: width,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * .02, vertical: height * .012),
                  margin: EdgeInsets.symmetric(
                      horizontal: width * .02, vertical: height * .012),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7.5),
                    boxShadow: const [
                      BoxShadow(
                        color: kGrey,
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: height * .07,
                        width: width * .11,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              ifmisMembersImages[index],
                            ),
                          ),
                          shape: CircleBorder(),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width * .02),
                      ),
                      showText(
                        text: ifmisMembersNames[index],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: height * .015,
              );
            },
            itemCount: ifmisMembersImages.length),
      ),
    );
  }
}
