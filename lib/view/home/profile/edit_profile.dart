import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/controllers/profile_controller.dart';
import 'package:news_app/models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController(text: user.userName);
  var numberController = TextEditingController(text: user.phone.tr);
  var emailController = TextEditingController(text: user.email);
  var countryController = TextEditingController(text: user.country.tr);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var profileController = Get.put(ProfileController());
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
        centerTitle: true,
        toolbarHeight: height * .073,
      ),
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: height * .9,
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
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() {
                          return profileController.isNewImage.value
                              ? CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      FileImage(profileController.image.value),
                                  backgroundColor: kWhite,
                                )
                              : CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      NetworkImage('$imageURL/${user.image}'),
                                  backgroundColor: kWhite,
                                );
                        }),
                        IconButton(
                            onPressed: () async {
                              await FilePicker.platform
                                  .pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'jpeg'],
                                allowMultiple: false,
                              )
                                  .then((value) {
                                value!;
                                profileController.updateImage(
                                  File(value.paths.first.toString()),
                                );
                              });
                            },
                            icon: const Icon(Iconsax.gallery_edit5))
                      ],
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
                              readOnly: false,
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
                              readOnly: false,
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
                              readOnly: false,
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
                              readOnly: false,
                            ),
                          ),
                          SizedBox(
                            height: height * .03,
                          ),
                          SizedBox(
                            height: height * .05,
                            width: width * .35,
                            child: Center(
                              child: Obx(() {
                                return profileController.isLoading.value
                                    ? myLoader()
                                    : ElevatedButton(
                                        onPressed: () async {
                                          print( profileController
                                              .image
                                              .value
                                              .path);
                                          profileController.isLoading.value =
                                              true;
                                          profileController.update();
                                          try{
                                            var response =
                                                await profileController
                                                    .apiController
                                                    .editProfile(
                                                        data: profileController
                                                                .isNewImage
                                                                .value
                                                            ? {
                                                                'phone':
                                                                    numberController
                                                                        .text,
                                                                'user_name':
                                                                    nameController
                                                                        .text,
                                                                'country':
                                                                    countryController
                                                                        .text,
                                                                'email':
                                                                    emailController
                                                                        .text,
                                                                'image':await dio
                                                                        .MultipartFile
                                                                    .fromFile(
                                                                  profileController
                                                                      .image
                                                                      .value
                                                                      .path,
                                                                )
                                                              }
                                                            : {
                                                                'phone':
                                                                    numberController
                                                                        .text,
                                                                'user_name':
                                                                    nameController
                                                                        .text,
                                                                'country':
                                                                    countryController
                                                                        .text,
                                                                'email':
                                                                    emailController
                                                                        .text,
                                                              })
                                                    .then((value) {
                                              Get.snackbar(
                                                  'Done'.tr,
                                                  'Profile updated successfully'
                                                      .tr,
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.3));
                                              profileController
                                                  .isLoading.value = false;
                                              AuthController().injectProfileData();
                                              profileController.update();
                                            });
                                          }on dio.DioError catch (error){
                                            print('\n massege : ${error.message}\n');
                                            print('body : ${error.response!.data.toString()}');
                                            profileController
                                                .isLoading.value = false;
                                            profileController.update();
                                          }
                                          // Get.offAll(() =>  HomeScreen());
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    kPrimaryColor)),
                                        child: showText(
                                          text: 'Save changes',
                                          textColor: kWhite,
                                          size: 12,
                                        ),
                                      );
                              }),
                            ),
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
      ),
    );
  }
}
