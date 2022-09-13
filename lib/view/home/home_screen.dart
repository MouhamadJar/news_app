import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:marquee/marquee.dart';
import 'package:news_app/controllers/home_controller.dart';
import 'package:news_app/controllers/language_controller.dart';
import 'package:news_app/controllers/text_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/home/profile/profile.dart';
import 'package:news_app/view/home/researches/researches.dart';
import 'package:news_app/view/home/services_for_sport/services_category.dart';
import 'package:news_app/view/home/sport_news/category_news.dart';
import 'package:news_app/view/home/stores/stores.dart';
import 'package:news_app/view/home/suggestions/suggestion_category.dart';
import 'package:news_app/view/home/trips/trips_category.dart';
import '../../controllers/network_controllers/api_controller.dart';
import '../../models/components/constants.dart';
import 'chat/chat_rooms.dart';
import 'comming_soon.dart';
import 'competition/competitions.dart';
import 'courses/courses_category.dart';
import 'drawer/conditions_for_obtaining_membership.dart';
import 'drawer/contact_us.dart';
import 'drawer/evacuation_responsibility.dart';
import 'drawer/ifmis_members.dart';
import 'drawer/intellectual_property_rights.dart';
import 'drawer/privacy_policy.dart';
import 'drawer/vision_mission_and_objective.dart';
import 'ifmis_news/category_ifmis_news.dart';
import 'sport_results/match_day_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  ScrollController newsController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageController = Get.put(LanguageController());
    Future<bool> onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: kWhite,
              elevation: 11,
              title: Text(
                'Are you sure?'.tr,
                style: TextController()
                    .getStyle(style: TextStyle(color: kPrimaryColor)),
              ),
              content: Text(
                'Do you want to exit an App'.tr,
                style: TextController()
                    .getStyle(style: TextStyle(color: kPrimaryColor)),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No'.tr,
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes'.tr,
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kWhite,
          drawer: Drawer(
            width: width * .55,
            backgroundColor: kPrimaryColor,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/drawer.jpeg'),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  opacity: 0.4,
                ),
                color: kPrimaryColor,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: width * .01, vertical: height * .012),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: (height * .15),
                      width: (width * .2),
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        image: DecorationImage(
                          image: AssetImage('assets/logo.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    showText(
                      text: 'IFMIS',
                      textColor: kWhite,
                      size: 24.0,
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        token == 'noToken'
                            ? loginValidateWidget()
                            : Get.to(
                                () => Profile(),
                              );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Profile',
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                        textColor: kWhite,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: const Icon(
                          Iconsax.profile_circle,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // Get.back();
                        // Get.to(
                        //   () => Competitions(),
                        // );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'My joining',
                        size: 12.0,
                        textColor: kWhite,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Iconsax.share,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const ComingSoon(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'My friends',
                        size: 12.0,
                        textColor: kWhite,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Iconsax.user_add,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const ComingSoon(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Warning messages',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Iconsax.shield_cross,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const IfmisMembers(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Union members',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.remember_me_outlined,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const VisionMissionAndObjective(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Vision, Mission and Objective',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.emoji_objects_outlined,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const PrivacyPolicy(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'privacy policy',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.policy_outlined,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const ConditionsForObtainingMembership(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Conditions for obtaining membership',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.list_alt,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const IntellectualPropertyRights(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'intellectual property rights',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.copyright_outlined,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const EvacuationResponsibility(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Evacuation responsibility',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Icons.copyright_sharp,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Get.to(
                          () => const ContactUs(),
                        );
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Contact us',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Iconsax.call,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        languageController.changeLanguage();
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'Change language',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child:const Icon(
                          Iconsax.language_square,
                          color: kWhite,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        APIController().logout();
                      },
                      selected: false,
                      selectedColor: kPrimaryColor,
                      title: showText(
                        text: 'logout',
                        textColor: kWhite,
                        size: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: SizedBox(
                        height: height * .035,
                        width: width * .05,
                        child: Icon(
                          Iconsax.logout,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
            actions: [
              IconButton(
                onPressed: () {
                  token == 'noToken'
                      ? loginValidateWidget()
                      : Get.to(
                          () => Profile(),
                        );
                },
                icon: const Icon(Iconsax.profile_circle),
              ),
            ],
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
          body: MySingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * .015,
                ),
                Container(
                  height: height * .04,
                  width: width,
                  decoration: const BoxDecoration(
                    color: kWhite,
                    boxShadow: [
                      BoxShadow(
                          color: kGrey, offset: Offset(0, 5), blurRadius: 5),
                    ],
                  ),
                  child: Marquee(
                    text: newsSliderData,
                    style: TextController().getStyle(
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 48.0,
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                SizedBox(
                  height: height * .015,
                ),
                Padding(
                  padding: EdgeInsets.all(width * .025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        height: height * .05,
                        width: width,
                        child: Center(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
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
                      SizedBox(
                        height: height * .015,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: width * .05,
                        runSpacing: height * .013,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Football Fans Chat',
                            details: 'details',
                            imageLink: 'assets/Football Fans Chat.jpg',
                            onTap: () {},
                            secondWidget: ChatRooms(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'competitions and Results',
                            details: 'details',
                            imageLink: 'assets/competitions and results.png',
                            onTap: () {},
                            secondWidget:  MatchDay(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Sport News',
                            details: 'details',
                            imageLink: 'assets/football News.jpg',
                            onTap: () {
                              Get.to(
                                () => CategoryNews(),
                              );
                            },
                            secondWidget: const ComingSoon(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Competitions and prizes',
                            details: 'details',
                            imageLink: 'assets/competitions .jpg',
                            onTap: () {
                              Get.to(
                                () => Competitions(),
                              );
                            },
                            secondWidget: Competitions(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Sport Courses',
                            details: 'details',
                            color: kBlack,
                            imageLink: 'assets/course.jpg',
                            onTap: () {},
                            secondWidget: CourseCategory(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Scientific Researches',
                            details: 'details',
                            imageLink: 'assets/scientific researches.jpg',
                            onTap: () {
                              Get.to(
                                () => Researches(),
                              );
                            },
                            secondWidget: Researches(),
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Clubs Results',
                            details: 'details',
                            imageLink: 'assets/Football services.jpg',
                            onTap: () {},
                            color: kBlack,
                            secondWidget: ComingSoon(),
                          ),
                          HomeCard(
                              height: height,
                              width: width,
                              name: 'International Union sports',
                              details: 'details',
                              imageLink: 'assets/pitch reservation.png',
                              onTap: () {},
                              secondWidget: const ComingSoon()),
                          HomeCard(
                              height: height,
                              width: width,
                              name: 'Sports jobs ads',
                              details: 'details',
                              imageLink: 'assets/Sports job ads.png',
                              onTap: () {},
                              secondWidget: const ComingSoon()),
                          HomeCard(
                              height: height,
                              width: width,
                              name: 'Success International Partners',
                              details: 'details',
                              imageLink: 'assets/Sports Antiques Auction.png',
                              onTap: () {},
                              secondWidget: const ComingSoon()),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Marketing talent players',
                            details: 'details',
                            imageLink: 'assets/Marketing talent players.png',
                            onTap: () {},
                            secondWidget: const ComingSoon(),
                            color: kBlack,
                          ),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Trips & Business',
                            details: 'details',
                            imageLink: 'assets/trips.jpg',
                            color: kBlack,
                            onTap: () {},
                            secondWidget: ComingSoon(),
                          ),
                          HomeCard(
                              height: height,
                              width: width,
                              name: 'Sports suggestions',
                              details: 'details',
                              imageLink: 'assets/sport advices.png',
                              onTap: () {},
                              secondWidget: SuggestionCategory()),
                          HomeCard(
                            height: height,
                            width: width,
                            name: 'Sport Store ',
                            details: 'details',
                            imageLink: 'assets/stores.jpg',
                            onTap: () {},
                            secondWidget: ComingSoon(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * .012,
                          ),
                          showText(text: 'visitor number', textColor: kBlack, size: 16),
                          showText(
                              text: '  : $appVisitorNumber',
                              textColor: kBlack,
                              size: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
