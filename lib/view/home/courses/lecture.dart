import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class Lecture extends StatefulWidget {
  const Lecture({Key? key, required this.pdfName, required this.youtubeLink, required this.courseName})
      : super(key: key);
  final String pdfName;
  final String youtubeLink;
  final String courseName;

  @override
  State<Lecture> createState() => _LectureState();
}

class _LectureState extends State<Lecture> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.youtubeLink).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        isLive: false,
        forceHD: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: Get.height * .1,
        width: Get.width,
        color: kPrimaryColor,
        child: PhysicalModel(
          color: Colors.grey.withOpacity(0.05),
          elevation: 5.0,
          child: CarouselSlider(
            items: sliderData.map((element) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Get.width * .03,
                ),
                width: Get.width,
                height: Get.height * .15,
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
              height: Get.height * .15,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration:
              const Duration(milliseconds: 750),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * .02, vertical: Get.height * .015),
            height: Get.height * .3,
            width: Get.width,
            child: YoutubePlayer(
              controller: _controller,
            ),
          ),
          SizedBox(height: Get.height * .07),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            width : Get.width,
            height : Get.height*.06,
            child: FittedBox(
              child: showText(
                text: widget.courseName,
                textColor: kBlack,
              ),
            ),
          ),
          SizedBox(height: Get.height * .07),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  width : Get.width,
                  height : Get.height*.04,
                  child: FittedBox(
                    child: showText(
                      text: 'Or download the lecture as pdf',
                      textColor: kBlack,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      APIController().downloadPdf(pdfName: widget.pdfName);
                    },
                    icon:  Image.asset('assets/pdf.png'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
