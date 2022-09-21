import  'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/models/Comments.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/network_controllers/api_controller.dart';

class ResearchDetails extends StatefulWidget {
  ResearchDetails({
    Key? key,
    required this.tag,
    required this.title,
    required this.image,
    required this.likesNumber,
    required this.images,
    required this.content,
    required this.dislikesNumber,
    required this.visitorNumber,
    required this.videoLink,
    required this.id,
    required this.isLiked,
    required this.isDisLiked,
    required this.comments,
  }) : super(key: key);
  final String tag;
  final String title;
  final String image;
  final String content;
  final String visitorNumber;
  final String videoLink;
  final int likesNumber;
  final int dislikesNumber;
  final int id;
  final List images;
  final List<Comments> comments;
  late bool isLiked;
  late bool isDisLiked;

  @override
  State<ResearchDetails> createState() => _ResearchDetailsState();
}

class _ResearchDetailsState extends State<ResearchDetails> {
  bool isLiked = false;
  bool isDisLiked = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    APIController().incrementVisitors(id: widget.id);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoLink).toString(),
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
    var height = Get.height;
    var width = Get.width;
    var homeController = Get.put(HomeController());
    widget.isLiked ? isLiked = widget.isLiked : null;
    widget.isDisLiked ? isDisLiked = widget.isDisLiked : null;
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
        title: SizedBox(
          width: width*.6,
          height: height*.05,
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: showText(
                  text: widget.title,
                  textColor: kPrimaryColor,
                  fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: MySingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.tag,
              child: Container(
                width: width,
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
                    image: AssetImage(
                      widget.image,
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
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
                        token == 'noToken'
                            ? loginValidateWidget()
                            : widget.isLiked
                                ? null
                                : APIController()
                                    .createLike(
                                        id: widget.id,
                                        type: 'Research/',
                                        value: 1)
                                    .then((value) {
                                    setState(() {
                                      print(value.data.toString());
                                      print(value.statusCode.toString());
                                      isLiked = true;
                                      isDisLiked = false;
                                      widget.isDisLiked = false;
                                    });
                                  });

                        setState(() {});
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
                    SizedBox(
                      width:  width*.015,
                    ),
                    AnimatedCrossFade(
                      firstChild: showText(
                          text:
                              '${widget.isLiked ? (widget.likesNumber - 1) : (widget.likesNumber)}',
                          textColor: kBlack),
                      secondChild: showText(
                        text: widget.isLiked
                            ? widget.likesNumber.toString()
                            : (widget.likesNumber + 1).toString(),
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
                        token == 'noToken'
                            ? loginValidateWidget()
                            : widget.isDisLiked
                                ? null
                                : APIController()
                                    .createLike(
                                        id: widget.id,
                                        type: 'Research/',
                                        value: 0)
                                    .then((value) {
                                    setState(() {
                                      print(value.data.toString());
                                      print(value.statusCode.toString());
                                      isDisLiked = true;
                                      isLiked = false;
                                      widget.isLiked = false;
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
                        crossFadeState: isDisLiked
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
                              '${widget.isDisLiked ? (widget.dislikesNumber - 1) : widget.dislikesNumber}',
                          textColor: kBlack),
                      secondChild: showText(
                        text:
                            '${widget.isDisLiked ? widget.dislikesNumber : (widget.dislikesNumber + 1)}',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Iconsax.user),
                  SizedBox(
                    width: width * .012,
                  ),
                  showText(text: 'visitor number', textColor: kBlack, size: 16),
                  showText(
                      text: '  : ${widget.visitorNumber}',
                      textColor: kBlack,
                      size: 16),
                ],
              ),
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
              child: ReadMoreText(
                widget.content,
                trimLines: 5,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more'.tr,
                trimExpandedText: 'Show less'.tr,
                lessStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                moreStyle: Get.locale == const Locale('ar', 'AE')
                    ? GoogleFonts.cairo(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                    : GoogleFonts.notoSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
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
              margin: EdgeInsets.symmetric(vertical: height * .015),
              padding: EdgeInsets.symmetric(horizontal: width * .015),
              height: (height * .25) * widget.images.length,
              width: width,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  height: height * .23,
                  width: width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(imageURL + widget.images[index].src),
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                    fit: BoxFit.fill,
                  )),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: height * .015,
                ),
                itemCount: widget.images.length,
              ),
            ),
            Container(
              height: height * .06,
              margin: EdgeInsets.symmetric(
                  vertical: height * .015, horizontal: width * .02),
              child: TextFormField(
                onFieldSubmitted: (value){
                  APIController().addComment(comment: value, type: 'Research', id: widget.id).then((value) {
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
              height: (height * .13) * widget.comments.length,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: width * .025),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => comment(
                  comments: widget.comments[index],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: height * .02,
                ),
                itemCount: widget.comments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
