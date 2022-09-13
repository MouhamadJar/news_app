import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x;
import 'package:flutter/material.dart';
import 'package:news_app/controllers/language_controller.dart';
import 'package:news_app/controllers/network_controllers/end_point.dart';
import 'package:news_app/controllers/shared/local/shared_preferences_controller.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/view/auth/login_screen.dart';
import 'package:news_app/view/auth/signup_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/components/constants.dart';

class APIController extends get_x.GetxController {
  late Dio dio;
  var languageController = get_x.Get.put(LanguageController());

  Map<String, dynamic> getAuth() => token == 'noToken'
      ? {}
      : {
          'Authorization': 'Bearer $token',
        };

  APIController() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://aurora-team.com/newsApp/public/api',
          receiveDataWhenStatusError: true,
          headers: {'Accept': 'application/json'}),
    );
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await dio.post(
      EndPoints().LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await dio.post(
      EndPoints().SIGNUP,
      data: {
        'fname': firstName,
        'lname': lastName,
        'email': email,
        'password': password,
        'password_confirmation': password
      },
    );
  }

  Future<dynamic> downloadPdf({
    required String pdfName,
  }) async {
    return launchUrlString(
        'http://aurora-team.com/newsApp/public/api/downloadPdf?src=$pdfName',
        mode: LaunchMode.externalApplication);
  }

  Future<Response> getCourses() async {
    return dio.get(
      '/${languageController.getLanguageCode()}/courseList',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getCourseLessons({
    required int id,
  }) async {
    return dio.get(
      '/${languageController.getLanguageCode()}/$id${EndPoints().LESSON}',
    );
  }

  Future<Response> getAllResearches() async {
    return dio.get(
      '${EndPoints().RESEARCHES}/${languageController.getLanguageCode()}/11',
      options: Options(
        headers: getAuth(),
      ),
    );
  }

  dynamic logout() {
    SharedPreferencesController().setString(key: 'token', value: 'noToken');
    token = 'noToken';
    get_x.Get.snackbar('Done'.tr, 'logged out successfully'.tr);
  }

  Future<Response> createLike({
    required int id,
    required String type,
    required int value,
  }) async {
    return dio.post(
      EndPoints().LIKE + type + id.toString(),
      data: {"is_like": value},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> addComment({
    required String comment,
    required String type,
    required int id,
  }) async {
    return dio.post(
      '/comment/$type/$id',
      data: {'comment': comment},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getQuiz({
    required int id,
  }) async {
    return dio.get(
      '/${languageController.getLanguageCode()}/$id/ListQuzie',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getProfile() async {
    return dio.get(
      EndPoints().PROFILE,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> incrementVisitors({
    required int id,
  }) async {
    return dio.post(EndPoints().INCREMENT + id.toString());
  }

  Future<Response> editProfile({
    required Map<String, dynamic> data,
  }) async {
    print(data.toString());
    return dio.post(
      EndPoints().EPROFILE,
      data: FormData.fromMap(data),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> sendQuizMark({
    required int mark,
    required int id,
  }) async {
    return dio.post(
      EndPoints().MARK,
      data: {
        'mark': mark,
        'course_id': id,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> search({
    required String type,
    required String value,
  }) async {
    return dio.post(
      '${EndPoints().SEARRCH}${languageController.getLanguageCode()}/$type',
      data: {
        'TextSearch': value,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getBannerImage() async {
    return dio.get(
      EndPoints().BANNER,
    );
  }

  Future<Response> getContactusInfo() async {
    return dio.get(
      EndPoints().CONTACTUS,
    );
  }

  Future<Response> getSiteInfo() async {
    return dio.get(
      EndPoints().SITEINFO,
    );
  }

  Future<Response> getBreakingNews() async {
    return dio.get(
      EndPoints().BREAKINGNEWS,
    );
  }

  Future<Response> createResearch({
    required String youtubeLink,
    required String title,
    required String body,
    required List images,
  }) async {
    return dio.post(
      EndPoints().CREATERESEARCH,
      data: FormData.fromMap({
        'link': youtubeLink,
        'title': title,
        'title_ar': title,
        'body': body,
        'body_ar': body,
        'src': [
          for (var item in images)
            {await MultipartFile.fromFile(item.path)}.toList()
        ],
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getIFMISMembers() async {
    return dio.get(
      EndPoints().IFMISMEMBERS + languageController.getLanguageCode(),
    );
  }

  Future<Response> createSuggestion({
    required String name,
    required int age,
    required String job,
    required String suggestionType,
    required String jobType,
    required String country,
    required File file,
    required int phoneNumber,
    required String email,
  }) async {
    return dio.post(
      EndPoints().CREATESUGGESTION,
      data: FormData.fromMap({
        'name': name,
        'age': age,
        'job': job,
        'sectionName': suggestionType,
        'typeOfJob': jobType,
        'country': country,
        'file': await MultipartFile.fromFile(file.path),
        'phoneNumber': phoneNumber,
        'email': email,
      }),
    );
  }

  Future<Response> sendCertificate({
    required int courseID,
  }) async {
    return dio.post(
      '/sendCertificate/$courseID',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getAllCompetitions() async {
    return dio
        .get('/${languageController.getLanguageCode()}/getListCompetition/');
  }

  Future<Response> getCompetitionDetails({
    required int id,
  }) async {
    return dio.get(
      '/getCompetitonById/${languageController.getLanguageCode()}/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> joinChatRoom({
    required int id,
  }) async {
    return dio.get(
      '/joinRoom/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> leaveChatRoom({
    required int id,
  }) async {
    return dio.get(
      '/leaveRoom/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getChatRoomMessages({
    required int id,
  }) async {
    return dio.get(
      '/getRoomMessages/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getChatRooms() async {
    return dio.get('/getRooms/${languageController.getLanguageCode()}/');
  }

  Future<Response> sendChatRoomMessage({
    required int id,
    required String message,
  }) async {
    return dio.post(
      '/createMessage/$id',
      data: {'message': message},
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> getProfileById({
    required int userId,
  }) async {
    return dio.get('/getProfileFromId/$userId');
  }

  Future<Response> getRoomUsers({
    required int roomId,
  }) async {
    return dio.get('/getUsersJoinedRoom/$roomId');
  }

  Future<Response> getDayMatches({
    required String date,
  }) async {
    return Dio().get(
        'https://apiv3.apifootball.com/?APIkey=e519213a5e4a834eb6e0e636372d043e2fa034ad70c672f2496cf86c8c1b6ce1&action=get_events&from=$date&to=$date&country_id=97,1,5,44,3,6,8,4&league_id=278,605,277,604,536,1,28,302,300,3,4,168,175,205,207,153,377,146,147,152');
  }

  Future<Response> addAppVisitor() async {
    return dio.get('/globalVisits');
  }

  Future<Response> getAppVisitorNumber() async {
    return dio.get(
      '/CountOfvisits',
    );
  }

  Future<Response> reportUser({
    required int userId,
  }) async {
    return dio.post('/reportUser', data: {'user_id': userId});
  }


}
