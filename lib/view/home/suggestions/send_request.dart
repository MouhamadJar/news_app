import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/suggestion_controller.dart';
import 'package:news_app/models/components/components.dart';
import '../../../models/components/constants.dart';
import '../home_screen.dart';

class SendRequest extends StatefulWidget {
  const SendRequest({Key? key, required this.suggestionType}) : super(key: key);
  final String suggestionType;

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  File pdf = File('');
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var jobController = TextEditingController();
  var emailController = TextEditingController();
  var numberController = TextEditingController();
  var countryController = TextEditingController();
  var detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var suggestionController = Get.put(SuggestionController());
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
            Get.back();
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        centerTitle: true,
        toolbarHeight: height * .073,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * .025),
          child: Form(
            key: formKey,
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height * .015,
                  ),
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/logo.jpg'),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your name',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your age',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: ageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your job',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: jobController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your email',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your number',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: numberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showText(
                        text: 'your country',
                        size: 16,
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      SizedBox(
                        height: height * .04,
                        width: width * .6,
                        child: TextFormField(
                          controller: countryController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * .25,
                        child: FittedBox(
                          child: showText(
                            text: 'the work details',
                            size: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      Container(
                        color: kWhite,
                        height: height * .07,
                        width: width * .6,
                        child: TextFormField(
                          controller: detailsController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'this field cant be empty'.tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * .5,
                        child: FittedBox(
                          child: showText(
                            text: 'please add pdf for your project',
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .015,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc'],
                            ).then((value) {
                              setState(() {
                                pdf = File(value!.paths.first.toString());
                              });
                            });
                          },
                          child: const Icon(
                            Iconsax.add,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  suggestionController.isSendingRequest.value
                      ? myLoader()
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              suggestionController.sendRequest(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                job: jobController.text,
                                suggestionType: widget.suggestionType,
                                jobType: detailsController.text,
                                country: countryController.text,
                                file: pdf,
                                phoneNumber: int.parse(numberController.text),
                                email: emailController.text,
                              );
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor)),
                          child: showText(
                            text: 'Send request',
                            textColor: kWhite,
                            size: 12,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
