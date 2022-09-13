import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controllers/sport_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/home/sport_results/match_details.dart';

import '../../../models/components/constants.dart';
import '../home_screen.dart';

class MatchDay extends StatelessWidget {
  const MatchDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SportController sportController = Get.put(SportController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
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
        ),
        body: GetBuilder<SportController>(
          initState: (state) {
            sportController.matches.isNotEmpty
                ? null
                : sportController.getDayMatches();
          },
          builder: (controller) => sportController.isLoadingMatches.value
              ? myLoader()
              : MySingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    showDatePicker(
                                            context: context,
                                            initialDate:
                                                sportController.day.value,
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2024),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:const ColorScheme.light(
                                              primary: kPrimaryColor,
                                              onPrimary: kWhite,
                                              onSurface: kPrimaryColor,
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                primary: Colors.red, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    )
                                        .then((value) {
                                          sportController.day.value = value!;
                                          sportController.getDayMatches();
                                    });
                                  },
                                  icon: const Icon(
                                      Icons.calendar_month_outlined)),
                              showText(
                                  text:
                                      '${sportController.day.value.year.toString()}-${sportController.day.value.month.toString()}-${sportController.day.value.day.toString()}'),
                            ],
                          ),
                          showText(
                              text: DateFormat('EEEE')
                                  .format(sportController.day.value)
                                  .tr),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    sportController.removeOneDay();
                                  },
                                  icon: const Icon(
                                      Icons.arrow_back_ios_outlined)),
                              IconButton(
                                  onPressed: () {
                                    sportController.addOneDay();
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        width: Get.width,
                        height:
                            (Get.height * .13) * sportController.matches.length,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sportController.matches.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: Get.height * .03,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              sportController.matches[index].matchStatus.isEmpty ?
                                  Get.snackbar('ops'.tr, 'No statics yet'.tr)
                                  : Get.to(()=> MatchDetails(match:sportController.matches[index],));
                            },
                            child : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: kGrey,
                                    offset: Offset(0, 3.0),
                                    blurRadius: 5.0,
                                  ),
                                ],
                                color: kWhite,
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              width: Get.width,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3.5),
                                        topRight: Radius.circular(3.5),
                                      ),
                                      color: kGrey.withOpacity(0.4),
                                    ),
                                    width: Get.width,
                                    height: Get.height * .03,
                                    child: Center(
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            showText(
                                              text: sportController
                                                  .matches[index].leagueName,
                                              textColor: kBlack,
                                              size: 12,
                                            ),
                                          const  SizedBox(
                                              width: 8,
                                            ),
                                            CachedNetworkImage(
                                              imageUrl: sportController
                                                  .matches[index].leagueLogo,
                                              height: Get.height * .0250 ,
                                              filterQuality: FilterQuality.high,
                                              placeholder: (context, url) =>const SizedBox(),
                                              errorWidget: (context, url, error) => const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.5),
                                      color: kWhite,
                                    ),
                                    width: Get.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  sportController.matches[index]
                                                      .teamHomeBadge),
                                              backgroundColor: Colors.transparent,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: Get.width * .2,
                                              child: showText(
                                                text: sportController
                                                    .matches[index]
                                                    .matchHometeamName,
                                                size: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        sportController
                                                .matches[index]
                                                .matchHometeamHalftimeScore
                                                .isEmpty
                                            ? showText(
                                                text: sportController
                                                    .matches[index].matchTime,
                                              )
                                            : Row(
                                                children: [
                                                  showText(
                                                      text: sportController
                                                              .matches[index]
                                                              .matchHometeamFtScore
                                                              .isEmpty
                                                          ? sportController
                                                                  .matches[index]
                                                                  .matchHometeamExtraScore
                                                                  .isEmpty
                                                              ? sportController
                                                                  .matches[index]
                                                                  .matchHometeamHalftimeScore
                                                              : sportController
                                                                  .matches[index]
                                                                  .matchHometeamExtraScore
                                                          : sportController
                                                              .matches[index]
                                                              .matchHometeamFtScore),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  showText(text: '-'),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  showText(
                                                      text: sportController
                                                              .matches[index]
                                                              .matchAwayteamFtScore
                                                              .isEmpty
                                                          ? sportController
                                                                  .matches[index]
                                                                  .matchAwayteamExtraScore
                                                                  .isEmpty
                                                              ? sportController
                                                                  .matches[index]
                                                                  .matchAwayteamHalftimeScore
                                                              : sportController
                                                                  .matches[index]
                                                                  .matchAwayteamExtraScore
                                                          : sportController
                                                              .matches[index]
                                                              .matchAwayteamFtScore),
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Get.width * .2,
                                              child: showText(
                                                text: sportController
                                                    .matches[index]
                                                    .matchAwayteamName,
                                                size: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  sportController.matches[index]
                                                      .teamAwayBadge),
                                              backgroundColor: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
