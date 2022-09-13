import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/auth_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/auth/signup_screen.dart';
import '../../controllers/text_controller.dart';
import '../../models/components/constants.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isSecret = false;
  final _formKey = GlobalKey<FormState>();

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textController = Get.put(TextController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
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
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .03, vertical: height * .01),
                height: animationController.value * (height * 0.005),
                width: width,
                decoration: const BoxDecoration(
                  color: kWhite,
                ),
                child: AnimatedCrossFade(
                  firstChild: SizedBox(),
                  secondChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width,
                      ),
                      showText(
                        text: 'Login',
                        size: 24.0,
                        textColor: kPrimaryColor,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: const BorderSide(
                                    color: kSecondColor,
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
                                    isSecret
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_rounded,
                                    color: isSecret ? kPrimaryColor : kGrey,
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
                                        controller.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: showText(
                                      text: 'Login',
                                      textColor: kWhite,
                                    ),
                                  );
                          }),
                    ],
                  ),
                  crossFadeState: animationController.value < 75
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 450),
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
                          image: AssetImage('assets/logo.jpg'))),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: height * .15,
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
                          () => const SignupScreen(),
                        );
                      },
                      child: showText(
                        text: 'Signup',
                        textColor: kWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
