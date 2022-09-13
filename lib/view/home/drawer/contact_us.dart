import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/components/constants.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    _launchEmail() async {
      if (await canLaunch("mailto:$contactusEmail")) {
        await launch("mailto:$contactusEmail");
      } else {
        throw 'Could not launch';
      }
    }

    _launchWhatsapp() async {
      if (await canLaunch("whatsapp://send?phone=$contactusPhone")) {
        await launch("whatsapp://send?phone=$contactusPhone");
      } else {
        throw 'Could not launch';
      }
    }

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
        centerTitle: true,
        toolbarHeight: height * .073,
      ),
      bottomNavigationBar: Container(
        height: height * .1,
        width: width,
        color: kPrimaryColor,
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * .02, vertical: height * .015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: (height * .31),
                width: (width * .42),
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                token == 'noToken' ? loginValidateWidget() : _launchWhatsapp();
              },
              child: SizedBox(
                width: width,
                height: height * .07,
                child: Row(
                  children: [
                    const Icon(
                      Icons.whatsapp,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(
                      width: width*.015,
                    ),
                    showText(
                      text: 'Whatsapp : ',
                      textColor: kWhite,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height*.015,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              onPressed: () {
                token == 'noToken' ? loginValidateWidget() : _launchEmail();
              },
              child: SizedBox(
                width: width,
                height: height * .07,
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined,
                        color: Colors.white, size: 32),
                    SizedBox(
                      width: width*.015,
                    ),
                    showText(
                      text:  'E-mail : ',
                      textColor: kWhite,
                    )
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
