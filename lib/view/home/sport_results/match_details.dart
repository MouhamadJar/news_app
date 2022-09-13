import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/sport_controller.dart';
import 'package:news_app/models/sport_matches_apis_model/MatchModel.dart';
import 'dart:math' as math;
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class MatchDetails extends StatelessWidget {
  const MatchDetails({
    Key? key,
    required this.match,
  }) : super(key: key);
  final MatchModel match;


  @override
  Widget build(BuildContext context) {
    List<Widget> detailsPages =[
      StaticsPage(match: match),
      LinesUpPage(match: match),
      Events(match: match),
    ];
    MatchDetailsController matchDetailsController =
        Get.put(MatchDetailsController());
    return Scaffold(
      backgroundColor: kWhite.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
        elevation: 0,
      ),
      body: MySingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * .2,
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .06, vertical: Get.height * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * .2,
                    height: Get.height * .15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          match.teamHomeBadge,
                          height: Get.height * .07,
                        ),
                        showText(
                          text: match.matchHometeamName,
                          size: 12,
                          textColor: kWhite,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .17,
                    height: Get.height * .15,
                    child: FittedBox(
                      child: Row(
                        children: [
                          showText(
                            text: match.matchHometeamFtScore.isEmpty
                                ? match.matchHometeamExtraScore.isEmpty
                                    ? match.matchHometeamHalftimeScore
                                    : match.matchHometeamExtraScore
                                : match.matchHometeamFtScore,
                            textColor: kWhite,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          showText(
                            text: match.matchStatus.tr,
                            textColor: kWhite,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          showText(
                            text: match.matchAwayteamFtScore.isEmpty
                                ? match.matchAwayteamExtraScore.isEmpty
                                    ? match.matchAwayteamHalftimeScore
                                    : match.matchAwayteamExtraScore
                                : match.matchAwayteamFtScore,
                            textColor: kWhite,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .2,
                    height: Get.height * .15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.network(
                          match.teamAwayBadge,
                          height: Get.height * .07,
                        ),
                        showText(
                          text: match.matchAwayteamName,
                          size: 12,
                          textColor: kWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GetBuilder<MatchDetailsController>(builder: (controller) {
              return Column(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * .06,
                    color: kPrimaryColor,
                    child: CustomNavigationBar(
                      backgroundColor: kPrimaryColor,
                      strokeColor: kWhite.withOpacity(0.4),
                      items: [
                        CustomNavigationBarItem(
                          icon: showText(
                            text: '',
                            textColor: kWhite,
                            size: 1,
                          ),
                          title: showText(
                            text: 'statics',
                            textColor: kWhite,
                            size: 12,
                          ),
                          selectedIcon: showText(
                            text: '',
                            textColor: kWhite,
                            size: 1,
                          ),
                          selectedTitle: showText(
                            text: 'statics',
                            textColor: kWhite,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ) as Text,
                        ),
                        CustomNavigationBarItem(
                          icon: showText(
                            text: '0',
                            textColor: kWhite,
                            size: 1,
                          ),
                          title: showText(
                            text: 'lines up',
                            textColor: kWhite,
                            size: 12,
                          ),
                          selectedIcon: showText(
                            text: '',
                            textColor: kWhite,
                            size: 1,
                          ),
                          selectedTitle: showText(
                            text: 'lines up',
                            textColor: kWhite,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ) as Text,
                        ),
                        CustomNavigationBarItem(
                          icon: showText(
                            text: '',
                            textColor: kWhite,
                            size: 1,
                          ),
                          title: showText(
                            text: 'events',
                            textColor: kWhite,
                            size: 12,
                          ),
                          selectedIcon: showText(
                            text: '',
                            textColor: kWhite,
                            size: 1,
                            fontWeight: FontWeight.bold,
                          ),
                          selectedTitle: showText(
                            text: 'events',
                            textColor: kWhite,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ) as Text,
                        ),
                      ],
                      currentIndex: matchDetailsController.currentIndex.value,
                      onTap: (newIndex) {
                        matchDetailsController.changePage(newIndex: newIndex);
                      },
                    ),
                  ),
                  detailsPages[matchDetailsController.currentIndex.value],
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Events extends StatelessWidget {
  const Events({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
            SizedBox(
              width: Get.width * .065,
            ),
            showText(
                text: 'scorers'.tr,
                textColor: kGrey,
                size: 12.0),
            SizedBox(
              width: Get.width * .065,
            ),
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(16),
          width : Get.width,
          height :match.goalscorer.isEmpty ? Get.height *.032 : (Get.height *.065)*match.goalscorer.length,
          child: ListView.builder(
            itemBuilder: (context,index){
              print(match.goalscorer[index].homeScorer);
              return match.goalscorer.isEmpty ?
              SizedBox(
                child: showText(text: 'no goals',size: 12,textColor: kBlack),
              ) :
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width : Get.width*.3,
                    child: showText(
                      text: match.goalscorer[index].homeScorer ,
                      size: 14,
                      textColor: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  showText(
                    text: '-',
                    size: 12,
                    textColor: kBlack,
                  ),
                  SizedBox(
                    width : Get.width*.3,
                    child: showText(
                        text:match.goalscorer[index].awayScorer.isEmpty ? '' :match.goalscorer[index].awayScorer,
                        size: 14,
                        textColor: kPrimaryColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              );
            },
            itemCount: match.goalscorer.isEmpty ? 1 : match.goalscorer.length,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
            SizedBox(
              width: Get.width * .065,
            ),
            showText(
                text: 'cards'.tr,
                textColor: kGrey,
                size: 12.0),
            SizedBox(
              width: Get.width * .065,
            ),
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          width : Get.width,
          height :match.cards.isEmpty ? Get.height *.032 : (Get.height *.04)*match.cards.length,
          child: ListView.builder(
            itemBuilder: (context,index) => match.cards.isEmpty ?
            SizedBox(
              child: showText(text: 'no card',size: 12,textColor: kBlack),
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showText(
                  text: match.cards[index].homeFault.isEmpty ? '' :match.cards[index].homeFault ,
                  size: 14,
                  textColor: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),

                showText(
                  text: match.cards[index].awayFault.isEmpty ? '' :match.cards[index].awayFault ,
                  size: 14,
                  textColor: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            itemCount: match.cards.isEmpty ? 1 : match.cards.length,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
            SizedBox(
              width: Get.width * .065,
            ),
            showText(
                text: 'Substitution'.tr,
                textColor: kGrey,
                size: 12.0),
            SizedBox(
              width: Get.width * .065,
            ),
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          width : Get.width,
          height : math.max(match.substitutions.home.length.toDouble(), match.substitutions.home.length.toDouble()) == 0 ? Get.height*.03 :math.max(match.substitutions.home.length.toDouble(), match.substitutions.home.length.toDouble())*Get.height*.05 ,
          child: ListView.builder(
            itemBuilder: (context,index) => match.cards.isEmpty ?
            SizedBox(
              child: showText(text: 'no substitutions',size: 12,textColor: kBlack),
            ) :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showText(
                  text: match.substitutions.home[index]['substitution'] ?? ''  ,
                  size: 12,
                  textColor: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),

                showText(
                  text:match.substitutions.away[index]['substitution'] ?? '' ,
                  size: 12,
                  textColor: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            itemCount: math.max(match.substitutions.home.length.toDouble(), match.substitutions.home.length.toDouble()) == 0 ? 1 :math.max(match.substitutions.home.length.toDouble(), match.substitutions.home.length.toDouble()).toInt(),
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}



class LinesUpPage extends StatelessWidget {
  const LinesUpPage({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
          ),
          showText(
            text: match.matchHometeamName,
            size: 16,
            textColor: kBlack,
            fontWeight: FontWeight.bold
          ),
          showText(
              text: match.matchHometeamSystem,
              size: 12,
              textColor: kBlack,
          ),
          const  SizedBox(height: 8,),
          SizedBox(
            width: Get.width,
            height: (Get.height*.03) * match.lineup.home.startingLineups.length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index) =>  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showText(
                    text:  match.lineup.home.startingLineups[index].lineupPlayer,
                    fontWeight: FontWeight.bold,
                    size: 12,
                    textColor: kBlack),
                showText(
                    text:  match.lineup.home.startingLineups[index].lineupNumber,
                    size: 12,
                    fontWeight: FontWeight.bold,
                    textColor: kBlack),

              ],
            ),itemCount: match.lineup.home.startingLineups.length,),
          ),
          const  SizedBox(height: 8,),
          showText(
              text: match.matchAwayteamName,
              size: 16,
              textColor: kBlack,
              fontWeight: FontWeight.bold
          ),
          showText(
            text: match.matchAwayteamSystem,
            size: 12,
            textColor: kBlack,
          ),
          const  SizedBox(height: 8,),
          SizedBox(
            width: Get.width,
            height: (Get.height*.03) * match.lineup.away.startingLineups.length,
            child: ListView.builder(itemBuilder: (context,index) =>  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                showText(
                    text:  match.lineup.away.startingLineups[index].lineupPlayer,
                    fontWeight: FontWeight.bold,
                    size: 12,
                    textColor: kBlack),
                showText(
                    text:  match.lineup.away.startingLineups[index].lineupNumber,
                    size: 12,
                    fontWeight: FontWeight.bold,
                    textColor: kBlack),

              ],
            ),
                itemCount: match.lineup.away.startingLineups.length,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

class StaticsPage extends StatelessWidget {
  const StaticsPage({
    Key? key,
    required this.match,
  }) : super(key: key);

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(120),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: kGrey,
                    value: 1,
                  ),
                  CircularProgressIndicator(
                    value: (double.parse(match.statistics[18].home
                            .substring(0, 1)) /
                        10),
                    color: kPrimaryColor,
                  ),
                  showText(
                    text: match.statistics[18].home,
                    size: 12,
                    textColor: kPrimaryColor,
                  ),
                ],
              ),
              showText(
                  text: match.statistics[18].type,
                  size: 18,
                  fontWeight: FontWeight.bold),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: kGrey,
                    value: 1,
                  ),
                  CircularProgressIndicator(
                    value: (double.parse(match.statistics[18].away
                            .substring(0, 1)) /
                        10),
                    color: kPrimaryColor,
                  ),
                  showText(
                    text: match.statistics[18].away,
                    size: 12,
                    textColor: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
            SizedBox(
              width: Get.width * .065,
            ),
            showText(
                text: 'statics'.tr,
                textColor: kGrey,
                size: 12.0),
            SizedBox(
              width: Get.width * .065,
            ),
            Container(
              height: Get.height * .001,
              width: Get.width * .3,
              color: kGrey,
            ),
          ],
        ),

        Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          width : Get.width,
          height : (Get.height *.032)*match.statistics.length,
          child: ListView.builder(

            itemBuilder: (context,index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showText(
                  text: match.statistics[index].home,
                  size: 12,
                  textColor: kPrimaryColor),
              showText(
                  text: match.statistics[index].type,
                  size: 12,
                  textColor: kBlack,
                  fontWeight: FontWeight.bold),
              showText(
                  text: match.statistics[index].away,
                  size: 12,
                  textColor: kPrimaryColor),
            ],
          ),
            itemCount: match.statistics.length,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),

      ],
    );
  }
}
