import 'dart:io';

import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/research_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:news_app/view/home/researches/research_details.dart';
import '../home_screen.dart';

class Researches extends StatelessWidget {
  Researches({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  var youtubeLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.height;
    var researchController = Get.put(
      ResearchController(),
    );
    var formKey = GlobalKey<FormState>();
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
          toolbarHeight: Get.height * .215,
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
        ),
        backgroundColor: Colors.white,
        body: GetBuilder<ResearchController>(builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: researchController.isLoadingResearches.value
                ? myLoader()
                : researchController.researches.isNotEmpty ?
            ListView.separated(
                    itemBuilder: (context, index) => OpenContainer(
                      closedBuilder: (context, action) => Container(
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
                        height: Get.height * .09,
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: Row(
                          children: [
                            Hero(
                              tag: '$index',
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kGrey,
                                    borderRadius: BorderRadius.circular(7.6),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/researsh.png'),
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    )),
                                height: Get.height * .07,
                                width: Get.width * .13,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * .035,
                            ),
                            SizedBox(
                              width: Get.width*.65,
                              height: Get.height * .075,
                              child: Center(
                                child: showText(
                                    text:
                                        researchController.researches[index].title,
                                    textColor: kBlack,
                                    size: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      openBuilder: (context, action) => ResearchDetails(
                        tag: '$index',
                        title: researchController.researches[index].title,
                        image: 'assets/researsh.png',
                        content: researchController.researches[index].body,
                        dislikesNumber:
                            researchController.researches[index].dislikes,
                        images: researchController.researches[index].images,
                        likesNumber: researchController.researches[index].likes,
                        visitorNumber: researchController
                            .researches[index].countOfVisitors.first
                            .toString(),
                        id: researchController.researches[index].id,
                        isLiked:
                            researchController.researches[index].isLike == 2
                                ? false
                                : researchController.researches[index].isLike[0]
                                            ['is_like'] ==
                                        '1'
                                    ? true
                                    : false,
                        isDisLiked:
                            researchController.researches[index].isLike == 2
                                ? false
                                : researchController.researches[index].isLike[0]
                                            ['is_like'] ==
                                        '0'
                                    ? true
                                    : false,
                        videoLink: researchController.researches[index].link,
                        comments: researchController.researches[index].comments,
                      ),
                      closedElevation: 0,
                      transitionDuration: const Duration(milliseconds: 300),
                      transitionType: ContainerTransitionType.fadeThrough,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: Get.height * .03,
                    ),
                    itemCount:researchController.researches.isNotEmpty ? researchController.researches.length : 1,
                    physics: const BouncingScrollPhysics(),
                  ):
            Center(child: showText(text: 'No research yet')) ,
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            token == 'noToken'
                ? loginValidateWidget()
                : Get.defaultDialog(
                    title: 'Add Research'.tr,
                    contentPadding:EdgeInsets.symmetric(horizontal: Get.width*.015),
                    titleStyle: researchController.textController.getStyle(),
                    content: SingleChildScrollView(
                      child: SizedBox(
                        width:  Get.width,
                        child: Obx(() {
                          return researchController.isAddingResearches.value
                              ? myLoader()
                              : Column(
                                children: [
                                  Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .15,
                                                child: FittedBox(
                                                  child: showText(
                                                    text: 'Research Title',
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                              Container(
                                                color: kWhite,
                                                height: height * .05,
                                                width: width * .2,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  keyboardType: TextInputType.name,
                                                  controller: titleController,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'title cant be empty'.tr;
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * .015,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .15,
                                                child: FittedBox(
                                                  child: showText(
                                                    text: 'Research Description',
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                              Container(
                                                color: kWhite,
                                                height: height * .05,
                                                width: width * .2,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  keyboardType: TextInputType.name,
                                                  controller: bodyController,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'desc cant be empty'.tr;
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * .015,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * .15,
                                                child: FittedBox(
                                                  child: showText(
                                                    text: 'Research Video Link',
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                              Container(
                                                color: kWhite,
                                                height: height * .05,
                                                width: width * .2,
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  maxLines: 1,
                                                  keyboardType: TextInputType.name,
                                                  controller: youtubeLinkController,
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'video link cant be empty'
                                                          .tr;
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.height * .015,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: width * .15,
                                                height: height*.03,
                                                child: FittedBox(
                                                  child: showText(
                                                    text: 'please add research photos',
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * .015,
                                              ),
                                              SizedBox(
                                                height: height*.03,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            kPrimaryColor),
                                                  ),
                                                  onPressed: () async {
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                      type: FileType.image,
                                                      allowMultiple: false,
                                                    )
                                                        .then((value) {
                                                      researchController.images.add(
                                                        File(
                                                          value!.paths.first.toString(),
                                                        ),
                                                      );
                                                      researchController.update();
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Iconsax.add,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          researchController.images.isEmpty
                                              ? SizedBox()
                                              : SizedBox(
                                                width: Get.width * .7,
                                                height: Get.height * .12,
                                                child:ListView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: researchController.images.length,
                                                  itemBuilder: (context, index) {
                                                    return Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.all(
                                                              Get.height * .01),
                                                          child: OpenContainer(
                                                            closedBuilder:
                                                                (context, action) =>
                                                                Container(
                                                                  height:
                                                                  Get.height * .1,
                                                                  width: Get.width * .25,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        3.5),
                                                                    image:
                                                                    DecorationImage(
                                                                      image: FileImage(
                                                                          researchController
                                                                              .images[
                                                                          index]),
                                                                      fit: BoxFit.fill,
                                                                      filterQuality:
                                                                      FilterQuality
                                                                          .high,
                                                                    ),
                                                                  ),
                                                                ),
                                                            openBuilder:
                                                                (context, action) =>
                                                                Scaffold(
                                                                  appBar: AppBar(
                                                                    backgroundColor:
                                                                    kWhite,
                                                                    leading: IconButton(
                                                                      onPressed: () {
                                                                        Get.back();
                                                                      },
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .keyboard_backspace,
                                                                        color: kBlack,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  body: Container(
                                                                    height: Get.height,
                                                                    width: Get.width,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          3.5),
                                                                      image:
                                                                      DecorationImage(
                                                                        image: FileImage(
                                                                            researchController
                                                                                .images[
                                                                            index]),
                                                                        fit:
                                                                        BoxFit.fill,
                                                                        filterQuality:
                                                                        FilterQuality
                                                                            .high,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                300),
                                                            transitionType:
                                                            ContainerTransitionType
                                                                .fadeThrough,
                                                            openElevation: 0,
                                                            closedElevation: 0,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              researchController
                                                                  .images
                                                                  .removeAt(index);
                                                              researchController
                                                                  .update();
                                                            },
                                                            icon: const Icon(
                                                              Iconsax.close_circle,
                                                              color: kPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                         researchController.images.isEmpty ? kGrey : kPrimaryColor),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        researchController.createResearch(
                                          youtubeLink:
                                          youtubeLinkController.text,
                                          title: titleController.text,
                                          body: bodyController.text,
                                          images: researchController.images,
                                        );
                                      }
                                    },
                                    child:showText(text: 'send request',textColor: kWhite,)
                                  ),
                                ],
                              );
                        }),
                      ),
                    ),
                  );
          },
          child: const Icon(Iconsax.add),
        ),
      ),
    );
  }
}
