import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/auth/login_screen.dart';
import 'package:news_app/view/home/home_screen.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/text_controller.dart';
import '../../models/components/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  bool isSecret = false;
  bool isSecretConfirm = false;
  final _formKey = GlobalKey<FormState>();
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 100.0,
    );
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
      print(animationController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textController = Get.put(TextController());
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              'assets/login background.svg',
              fit: BoxFit.fill,
              height: height,
              width: width,
            ),
          ),
          Positioned(
            top: (height * .05 + 100) - animationController.value,
            left: width * .2,
            right: width * .2,
            child: Container(
              height: (height * .15 + 100) - animationController.value,
              width: (width * .3 + 100) - animationController.value,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                image: DecorationImage(
                  image: AssetImage('assets/logo.jpg'),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: animationController.value * (height * 0.0079),
              padding: const EdgeInsets.only(top: 50),
              width: width,
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(35))),
              child: AnimatedCrossFade(
                firstChild: const SizedBox(),
                secondChild: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: width,
                        ),
                        showText(
                          text: 'Signup',
                          size: 24.0,
                          textColor: kPrimaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name'.tr;
                                    }
                                    return null;
                                  },

                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.drive_file_rename_outline,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: kSecondColor,
                                      ),
                                    ),
                                    labelText: 'Enter your First name'.tr,
                                    labelStyle: textController.getStyle(),
                                  ),
                                  style: textController.getStyle(
                                    style: const TextStyle(
                                        fontSize: 16, color: kSecondColor),
                                  ),
                                  controller: firstNameController,
                                ),
                                SizedBox(
                                  height: height * .021,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name'.tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.drive_file_rename_outline,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: kSecondColor,
                                      ),
                                    ),
                                    labelText: 'Enter your Last name'.tr,
                                    labelStyle: textController.getStyle(),
                                  ),
                                  style: textController.getStyle(
                                    style: const TextStyle(
                                        fontSize: 16, color: kSecondColor),
                                  ),
                                  controller: lastNameController,
                                ),
                                SizedBox(
                                  height: height * .021,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email'.tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.email_outlined,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: kSecondColor,
                                      ),
                                    ),
                                    labelText: 'Enter your E-mail'.tr,
                                    labelStyle: textController.getStyle(),
                                  ),
                                  style: textController.getStyle(
                                    style: const TextStyle(
                                        fontSize: 16, color: kSecondColor),
                                  ),
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: height * .021,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password'.tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    icon: const Icon(
                                      Icons.lock_outline,
                                      color: kPrimaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.5),
                                      borderSide: const BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      borderSide: const BorderSide(
                                        color: kSecondColor,
                                      ),
                                    ),
                                    labelText: 'Enter your password'.tr,
                                    labelStyle: textController.getStyle(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        !isSecret
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_rounded,
                                        color: !isSecret ? kPrimaryColor : kGrey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isSecret = !isSecret;
                                        });
                                      },
                                    ),
                                  ),
                                  style: textController.getStyle(
                                    style: const TextStyle(
                                        fontSize: 16, color: kSecondColor),
                                  ),
                                  obscureText: isSecret,
                                  controller: passwordController,
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height*.01,),
                        GetBuilder<AuthController>(
                            init: AuthController(),
                            builder: (controller) {
                              return controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          kPrimaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          controller.userSignup(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              firstName:
                                                  firstNameController.text,
                                              lastName:
                                                  lastNameController.text);
                                        }
                                      },
                                      child: showText(
                                        text: 'Signup',
                                        textColor: kWhite,
                                      ),
                                    );
                            }),
                      ],
                    ),
                    Container(
                      height: height * .12,
                      width: width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFb1292c),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(35.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/down.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.off(
                              () => const LoginScreen(),
                            );
                          },
                          child: showText(
                            text: 'Login',
                            textColor: kWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                crossFadeState: animationController.value < 75
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 450),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
