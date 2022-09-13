import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/home/profile/edit_profile.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  var nameController = TextEditingController(text: user.userName);
  var numberController = TextEditingController(
      text: user.phone == 'Please Complete the profile'
          ? 'الرجاء اكمال بيانات الحساب'
          : user.phone);
  var emailController = TextEditingController(text: user.email);
  var countryController = TextEditingController(
      text: user.country == 'Please Complete the profile'
          ? 'الرجاء اكمال بيانات الحساب'
          : user.country);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
              Get.offAll(
                () => HomeScreen(),
              );
            },
            icon: const Icon(Icons.home_rounded),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.to(
              () => EditProfile(),
            );
          },
          icon: const Icon(Iconsax.edit),
        ),
        centerTitle: true,
        toolbarHeight: height * .073,
      ),
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: height,
            width: width,
          ),
          SizedBox(
            height: height * .85,
            width: width,
            child: SvgPicture.asset(
              'assets/profile.svg',
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: height * .09,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage('$imageURL/${user.image}'),
                    backgroundColor: kWhite,
                  ),
                  Padding(
                    padding: EdgeInsets.all(width * .025),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          height: height * .015,
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        Container(
                          height: height * .06,
                          width: width * .8,
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          padding: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: false,
                              label: showText(
                                text: 'your name',
                                size: 12,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            style: Get.locale == const Locale('ar', 'AE')
                                ? GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          height: height * .06,
                          width: width * .8,
                          padding: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: TextFormField(
                            controller: numberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: false,
                              label: showText(
                                text: 'your number',
                                size: 12,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            style: Get.locale == const Locale('ar', 'AE')
                                ? GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          height: height * .06,
                          width: width * .8,
                          padding: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: false,
                              label: showText(
                                text: 'your email',
                                size: 12,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            style: Get.locale == const Locale('ar', 'AE')
                                ? GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          height: height * .06,
                          width: width * .8,
                          padding: const EdgeInsets.only(
                            top: 16,
                          ),
                          child: TextFormField(
                            controller: countryController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: false,
                              label: showText(
                                text: 'your country',
                                size: 12,
                              ),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                            ),
                            style: Get.locale == const Locale('ar', 'AE')
                                ? GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                      fontSize: 12.0,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        OpenContainer(
                          closedBuilder: (context, action) {
                            return Container(
                              height: height * .05,
                              width: width * .35,
                              color: kPrimaryColor,
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: showText(
                                    text: 'edit profile',
                                    textColor: kWhite,
                                    size: 12,
                                  ),
                                ),
                              ),
                            );
                          },
                          openBuilder: (context, action) {
                            return EditProfile();
                          },
                          transitionType: ContainerTransitionType.fadeThrough,
                          transitionDuration: const Duration(milliseconds: 450),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
