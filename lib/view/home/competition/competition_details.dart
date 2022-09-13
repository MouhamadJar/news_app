import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/join_controller.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/controllers/text_controller.dart';
import 'package:news_app/models/CompetitionDetails.dart';
import 'package:news_app/view/home/competition/member_details.dart';
import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class CompetitionDetails extends StatefulWidget {
  const CompetitionDetails({Key? key, required this.id, required this.image})
      : super(key: key);
  final int id;
  final String image;

  @override
  State<CompetitionDetails> createState() => _CompetitionDetailsState();
}

class _CompetitionDetailsState extends State<CompetitionDetails> {
  bool isLiked = false;
  bool isDisLiked = false;
  var bodyController = TextEditingController();
  var youtubeLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    var joinController = Get.put(JoinController());
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
        backgroundColor: Colors.white,
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
              Container(
                height: (Get.height * .05),
                width: (Get.width * .1),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
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
        body: FutureBuilder(
            future: APIController().getCompetitionDetails(id: widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dynamic data = snapshot.data;
                AllCompetitionDetails competition =
                    AllCompetitionDetails.fromJson(data.data['data']);
                return MySingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: height * .3,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      showText(
                        text: competition.name,
                        textColor: kBlack,
                        size: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: width,
                        height: height * .07,
                        child: AutoSizeText(
                          competition.details,
                          maxLines: 3,
                          maxFontSize: 12,
                          minFontSize: 12,
                          style: Get.locale == const Locale('ar', 'AE')
                              ? GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : GoogleFonts.notoSans(
                                  textStyle: const TextStyle(
                                    color: kBlack,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        children: [
                          showText(
                            text: 'The prize   :'.tr,
                            textColor: kBlack,
                            size: 12,
                          ),
                          showText(
                            text: competition.prize,
                            textColor: kBlack,
                            size: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
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
                          showText(
                              text: 'Latest videos'.tr,
                              textColor: kGrey,
                              size: 12.0),
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
                        height: competition.posts.isEmpty
                            ? height * .12
                            : (height * .13) * competition.posts.length,
                        child: competition.posts.isEmpty
                            ? Center(child: showText(text: 'No subscriber yet'))
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        token == 'noToken'
                                            ? loginValidateWidget()
                                            : Get.to(() => MemberDetails(
                                                post:
                                                    competition.posts[index]));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: width * .015),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * .015,
                                            vertical: height * .01),
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(3.5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: kGrey,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        '$imageURL/${competition.posts[index].user.image}',
                                                      ),
                                                      fit: BoxFit.cover)),
                                              height: height * .1,
                                              width: width * .2,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.play_circle,
                                                color: kGrey,
                                                size: 32,
                                              )),
                                            ),
                                            SizedBox(
                                              width: width * .02,
                                            ),
                                            showText(
                                                text: 'competition videos'.tr,
                                                textColor: kBlack,
                                                size: 12),
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: height * .015,
                                    ),
                                itemCount: competition.posts.length),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                        ),
                        onPressed: () {
                          token == 'noToken'
                              ? loginValidateWidget()
                              : Get.defaultDialog(
                                  title: 'Join competition'.tr,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: Get.width * .015),
                                  titleStyle: TextController().getStyle(),
                                  content: MySingleChildScrollView(
                                    child: SizedBox(
                                      width: Get.width,
                                      child: Obx(() {
                                        return joinController.isJoining.value
                                            ? myLoader()
                                            : Column(
                                                children: [
                                                  Form(
                                                    key: formKey,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Center(
                                                              child: SizedBox(
                                                                width:
                                                                    width * .1,
                                                                height: height*.04,
                                                                child: FittedBox(
                                                                  alignment: Alignment.bottomCenter,
                                                                  child: showText(
                                                                    text:
                                                                        'Description',
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * .015,
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * .05,
                                                              width: width * .6,
                                                              child:
                                                                  TextFormField(
                                                                    scrollPadding: EdgeInsets.zero,
                                                                decoration:
                                                                    const InputDecoration(
                                                                      fillColor: kWhite,
                                                                  filled: true,
                                                                  contentPadding:EdgeInsets.zero,
                                                                  border:
                                                                      OutlineInputBorder(),

                                                                ),
                                                                maxLines: 1,
                                                                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .name,
                                                                controller:
                                                                    bodyController,
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'desc cant be empty'
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
                                                          height:
                                                              Get.height * .015,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Center(
                                                              child: SizedBox(
                                                                width:
                                                                width * .1,
                                                                height: height*.04,
                                                                child: FittedBox(
                                                                  alignment: Alignment.bottomCenter,
                                                                  child: showText(
                                                                    text:
                                                                    'Video link',
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                              width * .015,
                                                            ),
                                                            Container(
                                                              height:
                                                              height * .05,
                                                              width: width * .6,
                                                              child:
                                                              TextFormField(
                                                                scrollPadding: EdgeInsets.zero,
                                                                decoration:
                                                                const InputDecoration(
                                                                  fillColor: kWhite,
                                                                  filled: true,
                                                                  contentPadding:EdgeInsets.zero,
                                                                  border:
                                                                  OutlineInputBorder(),

                                                                ),
                                                                maxLines: 1,
                                                                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                                keyboardType:
                                                                TextInputType
                                                                    .name,
                                                                controller:
                                                                youtubeLinkController,
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return  'video link cant be empty'
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
                                                          height:
                                                              Get.height * .015,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(kPrimaryColor),
                                                      ),
                                                      onPressed: () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          joinController
                                                              .joinCompetition(
                                                            body: bodyController
                                                                .text,
                                                            id: competition.id,
                                                            youtubeLink:
                                                                youtubeLinkController
                                                                    .text,
                                                          );
                                                        }
                                                      },
                                                      child: showText(
                                                        text: 'send request',
                                                        textColor: kWhite,
                                                      )),
                                                ],
                                              );
                                      }),
                                    ),
                                  ),
                                );
                        },
                        child: showText(
                            text: 'join'.tr, textColor: kWhite, size: 16),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(child: showText(text: 'Connection Error'));
              }
              return myLoader();
            }),
      ),
    );
  }
}
