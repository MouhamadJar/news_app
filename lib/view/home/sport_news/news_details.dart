import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:readmore/readmore.dart';

import '../../../controllers/home_controller.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails(
      {Key? key, required this.tag, required this.title, required this.image})
      : super(key: key);
  final String tag;
  final String title;
  final String image;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool isLiked = false;
  bool isDisLiked = false;

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    String content =
        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.';
    var homeController = Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: Container(
        height: height * .1,
        width: width,
        color: kWhite,
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
        foregroundColor: kPrimaryColor,
        backgroundColor: kWhite,
        elevation: 10,
        title: showText(
            text: widget.title,
            textColor: kPrimaryColor,
            size: 16.0,
            fontWeight: FontWeight.w600),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.tag,
              child:  Container(
                width: width,
                height: height * .2,
                margin: EdgeInsets.symmetric(
                  horizontal: width * .07,
                  vertical: height * .02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.image,
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                          isLiked
                              ? isDisLiked = false
                              : isDisLiked = isDisLiked;
                        });
                      },
                      child: AnimatedCrossFade(
                        firstChild: const Icon(
                          Iconsax.like_1,
                          size: 32,
                          color: Colors.black,
                        ),
                        secondChild: const Icon(
                          Iconsax.like_15,
                          size: 32,
                          color: Colors.blue,
                        ),
                        crossFadeState: isLiked
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 405),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: showText(text: '65', textColor: kBlack),
                      secondChild: showText(
                        text: '66',
                        textColor: Colors.blue,
                      ),
                      crossFadeState: isLiked
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 405),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDisLiked = !isDisLiked;
                          isDisLiked ? isLiked = false : isLiked = isLiked;
                        });
                      },
                      child: AnimatedCrossFade(
                        firstChild: const Icon(
                          Iconsax.dislike4,
                          size: 29,
                          color: Colors.black,
                        ),
                        secondChild: const Icon(
                          Iconsax.dislike5,
                          size: 29,
                          color: Colors.red,
                        ),
                        crossFadeState: isDisLiked
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 405),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: showText(text: '5', textColor: kBlack),
                      secondChild: showText(
                        text: '6',
                        textColor: Colors.red,
                      ),
                      crossFadeState: isDisLiked
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 405),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * .015),
              height: height * .002,
              width: width * 0.7,
              color: kGrey,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ReadMoreText(
                content,
                trimLines: 5,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.ibmPlexSansArabic(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                moreStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.ibmPlexSansArabic(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                style: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.ibmPlexSansArabic(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: kBlack,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
            Container(
              height: height * .06,
              margin: EdgeInsets.symmetric(
                  vertical: height * .015, horizontal: width * .02),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fillColor: kWhite,
                  filled: true,
                  label: showText(text: 'Leave a comment'.tr,textColor: kGrey,size: 12.0),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.send1),
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
