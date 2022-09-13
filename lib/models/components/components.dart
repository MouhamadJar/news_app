import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/Comments.dart';
import 'package:news_app/view/auth/login_screen.dart';
import 'package:news_app/view/auth/signup_screen.dart';
import 'constants.dart';

Widget showText({
  required String text,
  size = 0.0,
  textColor = Colors.black,
  fontWeight = FontWeight.normal,
}) =>
    Text(
      text.tr,
      style: Get.locale == const Locale('ar', 'AE')
          ? GoogleFonts.cairo(
              textStyle: TextStyle(
                fontSize: size == 0 ? 16 : size.toDouble(),
                color: textColor,
                fontWeight: fontWeight,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : GoogleFonts.rubik(
              textStyle: TextStyle(
                fontSize: size == 0 ? 16 : size.toDouble(),
                color: textColor,
                fontWeight: fontWeight,
                overflow: TextOverflow.ellipsis,
              ),
            ),
      maxLines: 10,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );

Widget HomeCard({
  required double height,
  required double width,
  required String name,
  required String details,
  required String imageLink,
  required VoidCallback onTap,
  required Widget secondWidget,
  color = null,
}) =>
    InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(13.2),
      child: OpenContainer(
        closedBuilder: (context, action) {
          return Container(
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(13.2),
                boxShadow: const [
                  BoxShadow(color: kGrey, blurRadius: 7),
                ],
                image: DecorationImage(
                  image: AssetImage(imageLink),
                  fit: BoxFit.cover,
                )),
            height: height * .235,
            width: width * .43,
            padding: EdgeInsets.symmetric(horizontal: width * .017),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .015,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SizedBox(
                    height: height * .025,
                    child: FittedBox(
                      child: showText(
                          text: name,
                          textColor: color ?? kWhite,
                          size: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        openBuilder: (context, action) {
          return secondWidget;
        },
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );

Widget myLoader() => const Center(
      child: CupertinoActivityIndicator(
        color: kPrimaryColor,
      ),
    );

Widget myFutureBuilder(Future futureFunction, Widget ifHasData) {
  return FutureBuilder(
      future: futureFunction,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ifHasData;
        }
        if (snapshot.hasError) {
          return showText(text: 'Connection error');
        }
        return myLoader();
      });
}

Future loginValidateWidget() => Get.defaultDialog(
  title: '',
  content:   Container(
    height: Get.height * .2,
    width: Get.width,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        showText(
          text: 'Please login to enjoy our services',
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          ),
          onPressed: () {
            Get.to(() => const LoginScreen());
          },
          child: showText(
            text: 'Login',
            textColor: Colors.white,
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          ),
          onPressed: () {
            Get.to(() => const SignupScreen());
          },
          child: showText(
            text: 'Signup',
            textColor: Colors.white,
          ),
        ),
      ],
    ),
  ),
);

Widget comment({
  required Comments comments,
}) =>
    Container(
      height: Get.height * .12,
      width: Get.width,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(3.50),
          boxShadow: const [
            BoxShadow(
              color: kGrey,
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .025, vertical: Get.height * .007),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage('$imageURL/${comments.user.image}'),
            ),
            SizedBox(
              width: Get.width * .07,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showText(text: comments.user.userName),
                SizedBox(
                  height: Get.height * .02,
                ),
                showText(text: comments.comment, textColor: kGrey),
              ],
            ),
          ],
        ),
      ),
    );

class MySingleChildScrollView extends StatelessWidget {
  const MySingleChildScrollView({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: child,
    );
  }
}
