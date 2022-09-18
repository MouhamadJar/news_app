import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/courses_controller.dart';
import 'package:news_app/models/LessonModel.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:news_app/view/home/courses/lecture.dart';

import '../../../controllers/home_controller.dart';
import '../home_screen.dart';
import 'quiz.dart';

class Course extends StatelessWidget {
  const Course(
      {Key? key,
      required this.courseID,
      required this.image,
      required this.successRate,
      required this.courseName,})
      : super(key: key);
  final int successRate;
  final int courseID;

  final String image;
  final String courseName;
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.height;
    var courseController = Get.put(CoursesController());

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
                    onTap: () {},
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
        body: FutureBuilder(
            future: courseController.getLessons(id: courseID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic response = snapshot.data;
                List data = response.data['data'];
                List<LessonModel> lessons = [];
                for (var value in data) {
                  lessons.add(LessonModel.fromJson(value));
                }
                return MySingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: (Get.height * .15) * lessons.length,
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: Get.height * .02,
                            horizontal: Get.width * 0.021),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              token == 'noToken'
                                  ? loginValidateWidget()
                                  : Get.to(() => Lecture(
                                courseName: courseName,
                                      successRate: successRate,
                                      courseID: courseID,
                                      pdfName:
                                          lessons[index].files.first.type ==
                                                  'pdf'
                                              ? lessons[index].files.first.src
                                              : lessons[index].files.last.src,
                                      youtubeLink:
                                          lessons[index].files.first.type ==
                                                  'mp4'
                                              ? lessons[index].files.first.src
                                              : lessons[index].files.last.src));
                            },
                            child: Container(
                              height: Get.height * .12,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * .2,
                                    height: Get.height * .09,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: kGrey,
                                          blurRadius: 5,
                                        ),
                                      ],
                                      image: const DecorationImage(
                                          image:
                                              AssetImage('assets/course.jpg'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_circle,
                                        color: kWhite,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * .02,
                                  ),
                                  SizedBox(
                                    width: Get.width * .5,
                                    child: showText(
                                      text: lessons[index].name,
                                      textColor: kBlack,
                                      size: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            color: kPrimaryColor,
                          ),
                          itemCount: lessons.length,
                        ),
                      ),

                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return showText(text: 'Connection error');
              }
              return myLoader();
            }),
      ),
    );
  }


}
