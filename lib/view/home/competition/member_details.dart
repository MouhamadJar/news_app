import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/models/Comments.dart';
import 'package:news_app/models/Posts.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../controllers/home_controller.dart';
import '../../../controllers/network_controllers/api_controller.dart';

class MemberDetails extends StatefulWidget {
  MemberDetails({
    Key? key,
    required this.post,
  }) : super(key: key);
   final Posts post;

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  late YoutubePlayerController _controller;

  late bool isLiked;
  late bool isdisLiked;

  @override
  void initState() {

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.post.video).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        isLive: false,
        forceHD: false,
      ),
    );
    if(widget.post.isLike.isNotEmpty){
        if(widget.post.isLike.first.isLike.toString() == '1'){
        isLiked = true;
        isdisLiked = false;
      }else{
        isLiked = false;
        isdisLiked = true;
      }
    }else{
      isLiked = false;
      isdisLiked = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

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
        elevation: 0,
      ),
      body: MySingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width*.5,
              height: height * .2,
              margin: EdgeInsets.symmetric(
                horizontal: width * .07,
                vertical: height * .02,
              ),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: kGrey,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(
                    '$imageURL/${widget.post.user.image}',
                  ),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
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
                        token == 'noToken'
                            ? loginValidateWidget()
                            : isLiked
                            ? null
                            : APIController()
                            .createLike(
                            id: widget.post.id,
                            type: 'PostCompatition/',
                            value: 1)
                            .then((value) {
                          setState(() {
                            print(value.data.toString());
                            print(value.statusCode.toString());
                            isLiked = true;
                            isdisLiked = false;
                          });
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
                        crossFadeState:isLiked
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 405),
                      ),
                    ),
                    SizedBox(
                      width:  width*.015,
                    ),
                    AnimatedCrossFade(
                      firstChild: showText(
                          text:
                          widget.post.likes.toString(),
                          textColor: kBlack),
                      secondChild: showText(
                        text: widget.post.likes.toString(),
                        textColor: Colors.blue,
                      ),
                      crossFadeState:isLiked
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
                        token == 'noToken'
                            ? loginValidateWidget()
                            :isdisLiked
                            ? null
                            : APIController()
                            .createLike(
                            id: widget.post.id,
                            type: 'PostCompatition/',
                            value: 0)
                            .then((value) {
                          setState(() {
                            print(value.data.toString());
                            print(value.statusCode.toString());
                            isdisLiked = true;
                            isLiked = false;
                          });
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
                        crossFadeState:isdisLiked
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 405),
                      ),
                    ),
                    SizedBox(
                      width:  width*.015,
                    ),
                    AnimatedCrossFade(
                      firstChild: showText(
                          text:
                          widget.post.desLike.toString(),
                          textColor: kBlack),
                      secondChild: showText(
                        text:
                        '${widget.post.desLike + 1}',
                        textColor: Colors.red,
                      ),
                      crossFadeState:isdisLiked
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
              margin: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .015),
              height: height * .3,
              width: width,
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: Get.width,
              child: ReadMoreText(
                widget.post.body,
                trimLines: 5,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more'.tr,
                trimExpandedText: 'Show less'.tr,
                lessStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                moreStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                style: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
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
                onFieldSubmitted: (value){
                  APIController().addComment(comment: value, type: 'Post', id: widget.post.id).then((value) {
                    Get.snackbar('Done', 'comment add successfully',backgroundColor: Colors.green.withOpacity(0.3));
                  }).catchError((onError){
                    print(onError.toString());
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fillColor: kWhite,
                  filled: true,
                  label: showText(
                      text: 'Leave a comment'.tr, textColor: kGrey, size: 12.0),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.send1),
                  ),
                ),
                readOnly: token == 'noToken',
                onTap: () {
                  token == 'noToken' ? loginValidateWidget() : null;
                },
              ),
            ),
            Container(
              height: (height * .13) * widget.post.comments.length,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: width * .025),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => comment(
                  comments: widget.post.comments[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: height * .02,
                ),
                itemCount: widget.post.comments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
