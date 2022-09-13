import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:news_app/view/home/courses/free_courses.dart';
import '../../../controllers/home_controller.dart';
import '../home_screen.dart';

class CourseCategory extends StatelessWidget {
  CourseCategory({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.height;
    var homeController = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
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
          //toolbarHeight: Get.height * .215,
          centerTitle: true,
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
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .03,
              ),
              OpenContainer(
                closedElevation: 0,
                transitionDuration: const Duration(milliseconds: 300),
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder: (context,action)=> Container(
                  margin: EdgeInsets.symmetric(horizontal: width*.0245,vertical: height*.01),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7.6),
                    boxShadow:const [
                      BoxShadow(
                          color: kGrey,
                          blurRadius: 5,
                          offset: Offset(0  , 1)
                      ),
                    ],
                  ),
                  height: Get.height * .09,
                  width: Get.width,
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
                                  image: AssetImage('assets/course.jpg'),
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                )),
                            height: Get.height * .07,
                            width: Get.width * .13,
                          ),
                          SizedBox(
                            width: Get.width * .035,
                          ),
                          showText(
                              text: 'Free Courses'.tr,
                              textColor: kBlack,
                              size: 16.0),
                        ],
                      ),
                    ],
                  ),
                ),
                openBuilder: (context,action) => FreeCourses(),
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              OpenContainer(
                closedElevation: 0,
                transitionDuration: const Duration(milliseconds: 300),
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder: (context,action)=>Container(
                  margin: EdgeInsets.symmetric(horizontal: width*.0245,vertical: height*.01),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7.6),
                    boxShadow:const [
                      BoxShadow(
                          color: kGrey,
                          blurRadius: 5,
                          offset: Offset(0  , 1)
                      ),
                    ],
                  ),
                  height: Get.height * .09,
                  width: Get.width,
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
                                  image: AssetImage('assets/course.jpg'),
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                )),
                            height: Get.height * .07,
                            width: Get.width * .13,
                          ),
                          SizedBox(
                            width: Get.width * .035,
                          ),
                          showText(
                              text: 'Paid courses'.tr,
                              textColor: kBlack,
                              size: 16.0),
                        ],
                      ),
                    ],
                  ),
                ),
                openBuilder: (context,action) => Scaffold(
                    appBar: AppBar(backgroundColor: kWhite,foregroundColor: kBlack,),
                    body: const Center(child: Text('building'),)),
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              OpenContainer(
                closedElevation: 0,
                transitionDuration: const Duration(milliseconds: 300),
                transitionType: ContainerTransitionType.fadeThrough,
                closedBuilder: (context,action)=>Container(
                  margin: EdgeInsets.symmetric(horizontal: width*.0245,vertical: height*.01),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(7.6),
                    boxShadow:const [
                      BoxShadow(
                          color: kGrey,
                          blurRadius: 5,
                          offset: Offset(0  , 1)
                      ),
                    ],
                  ),
                  height: Get.height * .09,
                  width: Get.width,
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
                                  image: AssetImage('assets/course.jpg'),
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                )),
                            height: Get.height * .07,
                            width: Get.width * .13,
                          ),
                          SizedBox(
                            width: Get.width * .035,
                          ),
                          showText(
                              text: 'In person courses'.tr,
                              textColor: kBlack,
                              size: 16.0),
                        ],
                      ),
                    ],
                  ),
                ),
                openBuilder: (context,action) => Scaffold(
                    appBar: AppBar(backgroundColor: kWhite,foregroundColor: kBlack,),
                    body: const Center(child: Text('building'),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
