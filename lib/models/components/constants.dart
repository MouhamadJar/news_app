import 'package:flutter/material.dart';
import 'package:news_app/models/UserModel.dart';

const kWhite = Colors.white;
const kBlack = Colors.black;
const kGrey = Colors.grey;
const kPrimaryColor = Color(0xFFaa121b);
const kPrimaryColorWithDarkness = Color(0xFFaa121f);
const kSecondColor = Color(0xFF69696B);

String token = '';
UserModel user = UserModel(image: '' ,email: '' ,id: 1,userName: '',country: '',phone: '');
String language = '';
String myTheme = '';
String imageURL = 'https://aurora-team.com/newsApp/public/storage';
String vision = '';
String contactusPhone = '';
String contactusEmail = '';
String privacyPolicy = '';
String appVisitorNumber = '';
String conditionsForObtainingMembership = '';
String intellectualPropertyRights = '';
String evacuationResponsibility = '';

var sliderData = [];
var newsSliderData = '';

List<String> ifmisMembersImages = [];
List<String> ifmisMembersNames = [];
List<String> ifmisMembersSpecialization = [];
List<String> ifmisMembersCountry = [ ];
List<String> ifmisMembersFlag = [ ];

