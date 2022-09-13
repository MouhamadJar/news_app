import 'package:news_app/controllers/language_controller.dart';

class EndPoints {
   final String LOGIN = '/login';
   final String SIGNUP = '/sigin';
   final String LESSON = '/ListLessionForCourse';
   final String RESEARCHES = '/getResearch';
   final String LIKE = '/like/';
   final String INCREMENT = '/counterIncrement/';
   final String PROFILE = '/getProfile';
   final String EPROFILE = '/UpdateProfile';
   final String MARK  = '/ResultQuzie';
   final String SEARRCH  = '/search/';
   final String BANNER  = '/ListImage';
   final String SITEINFO  = '/getSiteInfo/${LanguageController().getLanguageCode()}';
   final String BREAKINGNEWS   = '/listAds';
   final String CREATERESEARCH   = '/createResearch';
   final String IFMISMEMBERS   = '/getListOfMembers/';
   final String CREATESUGGESTION   = '/createSuggestion';
   final String CONTACTUS   = '/contactUs';

}