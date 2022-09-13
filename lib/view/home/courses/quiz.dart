import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/controllers/question_controller.dart';
import 'package:news_app/controllers/text_controller.dart';
import 'package:news_app/models/QuestionModel.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/home/profile/edit_profile.dart';

import '../../../models/components/constants.dart';
import '../home_screen.dart';

class Quiz extends StatelessWidget {
  const Quiz({
    Key? key,
    required this.successRate,
    required this.id,
  }) : super(key: key);
  final int successRate;
  final int id;

  @override
  Widget build(BuildContext context) {
    bool checkSuccess(sum) => sum < successRate;
    return Scaffold(
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
      body: FutureBuilder(
          future: APIController().getQuiz(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic response = snapshot.data;
              List<QuestionModel> questions = [];
              List<Question> questionWidgets = [];
              for (var value in response.data['data']) {
                questions.add(QuestionModel.fromJson(value));
              }
              var questionController = Get.put(QuestionController());
              return Column(
                children: [
                  SizedBox(
                    height: (Get.height * .15) * questions.length,
                    width: Get.width,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          Question newQuestion = Question(
                            question: questions[index],
                          );
                          questionWidgets.add(newQuestion);
                          return newQuestion;
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: Get.height * .01,
                            ),
                        itemCount: questions.length),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    onPressed: () {
                      int sum = 0;
                      for (int i = 0; i < questionWidgets.length; i++) {
                        sum += questionWidgets[i].questionController.mark.value;
                      }
                      print(((sum / questions.length) * 100).toString());
                      APIController()
                          .sendQuizMark(
                        mark: ((sum / questions.length) * 100).toInt(),
                        id: id,
                      )
                          .catchError((onError) {
                        print(onError.toString());
                      });
                      Get.defaultDialog(
                        title: checkSuccess((sum / questions.length) * 100)
                            ? 'Unfortunately'.tr
                            : 'Congratulations'.tr,
                        titleStyle: TextController().getStyle(),
                        content: checkSuccess((sum / questions.length) * 100)
                            ? Column(
                                children: [
                                  showText(
                                    text: 'you failed in this quiz'.tr,
                                  ),
                                  SizedBox(
                                    height: Get.height * .015,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              kPrimaryColor),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: showText(
                                      text: 'Ok'.tr,
                                      textColor: kWhite,
                                    ),
                                  )..marginSymmetric(
                                      vertical: Get.height * .02),
                                ],
                              )
                            : Obx(
                                () => Column(
                                  children: [
                                    showText(
                                      text:
                                          'We will send the certificate to this email',
                                    )..marginSymmetric(
                                        vertical: Get.height * .02),
                                    showText(
                                        text: 'please ensure this your E-mail')
                                      ..marginSymmetric(
                                          vertical: Get.height * .02),
                                    showText(text: user.email)
                                      ..marginSymmetric(
                                          vertical: Get.height * .02),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryColor),
                                      ),
                                      onPressed: () {
                                        Get.to(() => EditProfile());
                                      },
                                      child: showText(
                                        text: 'Edit email',
                                        textColor: kWhite,
                                      ),
                                    )..marginSymmetric(
                                        vertical: Get.height * .02),
                                    questionController
                                            .isSendingCertificate.value
                                        ? myLoader()
                                        : ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kPrimaryColor),
                                            ),
                                            onPressed: () {
                                              questionController
                                                  .isSendingCertificate
                                                  .value = true;
                                              questionController.update();
                                              APIController()
                                                  .sendCertificate(courseID: id)
                                                  .then((value) {
                                                questionController
                                                    .isSendingCertificate
                                                    .value = false;
                                                questionController.update();
                                                Get.snackbar('Done'.tr,
                                                    'the certificate sent'.tr,
                                                    backgroundColor: Colors
                                                        .green
                                                        .withOpacity(0.45));
                                              }).catchError((onError) {
                                                questionController
                                                    .isSendingCertificate
                                                    .value = false;
                                                questionController.update();
                                                Get.snackbar(
                                                    'ops'.tr,
                                                    'the certificate has already been sent'
                                                        .tr,
                                                    backgroundColor: Colors.red
                                                        .withOpacity(0.5));
                                              });
                                            },
                                            child: showText(
                                              text: 'Send certificate',
                                              textColor: kWhite,
                                            ),
                                          )
                                      ..marginSymmetric(
                                          vertical: Get.height * .02),
                                    showText(
                                        text:
                                            'Note : This certificate sent once time only !',
                                        textColor: kPrimaryColor)
                                      ..marginSymmetric(
                                          vertical: Get.height * .02),
                                  ],
                                ),
                              ),
                      );
                    },
                    child: showText(
                      text: 'send answers',
                      textColor: kWhite,
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {}
            return myLoader();
          }),
    );
  }
}

class Question extends StatelessWidget {
  Question({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuestionModel question;
  final QuestionController questionController = QuestionController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * .02, vertical: Get.height * .015),
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02, vertical: Get.height * .015),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: const [
          BoxShadow(
            color: kGrey,
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(3.5),
      ),
      child: Row(
        children: [
          SizedBox(
              width: Get.width * .55,
              child: showText(
                text: question.question,
                size: 12,
              )),
          const Spacer(),
          Obx(
            () => Row(
              children: [
                IconButton(
                  onPressed: () {
                    questionController.changeMark(true, question.correctAnswer);
                  },
                  icon: Icon(
                    questionController.isTrue.value
                        ? Icons.check_box
                        : Icons.check,
                    color:
                        questionController.isTrue.value ? Colors.green : kGrey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    questionController.changeMark(
                        false, question.correctAnswer);
                  },
                  icon: Icon(
                    questionController.isFalse.value
                        ? Icons.close
                        : Icons.close,
                    color:
                        questionController.isFalse.value ? Colors.red : kGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
