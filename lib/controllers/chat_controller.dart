import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:iconsax/iconsax.dart';
import 'package:news_app/controllers/network_controllers/api_controller.dart';
import 'package:news_app/models/RoomModel.dart';
import 'package:news_app/models/UserModel.dart';
import 'package:news_app/models/components/components.dart';
import 'package:news_app/models/components/constants.dart';

import '../view/home/chat/chat_screen.dart';

class ChatController extends GetxController {
  RxBool isLoadingRooms = true.obs;
  RxBool isLoadingRoomMembers = true.obs;

  APIController apiController = Get.put(APIController());

  ChatUser myUser = ChatUser(
      id: user.id.toString(),
      firstName: user.userName,
      profileImage: '$imageURL/${user.image}');
  List<ChatMessage> messages = [];
  List<RoomModel> rooms = [];
  List<UserModel> roomMembers = [];

  dynamic insertNewMessage({
    required ChatMessage newMessage,
    required int id,
  }) async {
    await apiController.sendChatRoomMessage(id: id, message: newMessage.text);
    messages.insert(0, newMessage);
    update();
  }

  Future<dynamic> loadRooms() async {
    var response = await apiController.getChatRooms();
    if (response.statusCode == 200) {
      for (var room in response.data['data']) {
        rooms.add(RoomModel.fromJson(room));
      }
      isLoadingRooms.value = false;
      update();
    } else if (response.statusCode! < 299) {
      Get.snackbar(
        'ops'.tr,
        'Connection error'.tr,
        backgroundColor: Colors.red.withOpacity(0.5),
      );
      isLoadingRooms.value = false;
      update();
    }
  }

  Future<dynamic> joinRoom({
    required int id,
    required Color color,
    required String roomName,
  }) async {
    Get.defaultDialog(
      title: 'Joining Room'.tr,
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: myLoader(),
      ),
    );
    var response = await apiController.joinChatRoom(id: id);
    if (response.statusCode == 200) {
      debugPrint(response.data.toString());
      if (response.data == 'The Room Is Full Or You Already joined') {
        Get.back();
        Get.snackbar(
          'ops'.tr,
          'Room is full'.tr,
          backgroundColor: Colors.red.withOpacity(0.5),
        );
      } else {
       return Get.to(
          () => ChatScreen(
            color: color,
            id: id,
            roomName: roomName,
          ),
        );
      }
      isLoadingRooms.value = false;
      update();
    } else if (response.statusCode! < 299) {
      Get.snackbar(
        'ops'.tr,
        'Connection error'.tr,
        backgroundColor: Colors.red.withOpacity(0.5),
      );
      Get.back();
    }
  }

  Future<dynamic> loadMessages({
    required int id,
  }) async {
    var response = await apiController.getChatRoomMessages(id: id);
    if (response.statusCode == 200 && response.data['data'].isNotEmpty) {
      if (messages.isEmpty) {
        for (var message in response.data['data']) {
          messages.insert(
            0,
            ChatMessage(
              user: ChatUser(
                  id: message['user']['id'].toString(),
                  firstName: message['user']['user_name'],
                  profileImage: '$imageURL/${message['user']['image']}'),
              text: message['message'],
              createdAt: DateTime.parse(
                message['created_at'].toString(),
              ),
            ),
          );
          update();
        }
      } else {
        int length = messages.length ;
        for (length; length < response.data['data'].length; length++) {
          messages.insert(
            0,
            ChatMessage(
              user: ChatUser(
                  id: response.data['data'][length]['user']['id'].toString(),
                  firstName: response.data['data'][length]['user']['user_name'],
                  profileImage:
                      '$imageURL/${response.data['data'][length]['user']['image']}'),
              text: response.data['data'][length]['message'],
              createdAt: DateTime.parse(
                response.data['data'][length]['created_at'].toString(),
              ),
            ),
          );
          update();
        }
      }
    } else if (response.statusCode! < 299) {}
    Future.delayed(const Duration(seconds: 3)).then((value) {
      loadMessages(id: id);
    });
  }

  dynamic leaveRoom({
    required int id,
  }) async {
    await apiController.leaveChatRoom(id: id).then((value) {
      Get.back();
      Get.back();
      messages.clear();
      roomMembers.clear();
    }).catchError((onError) {});
  }

  dynamic getUserProfile({
    required String userId,
    required Color color,
  }) async {
    RxBool isLoadingProfile = true.obs;
    UserModel user = UserModel(
        id: 1,
        email: 'email',
        userName: 'userName',
        country: 'country',
        phone: 'phone',
        image: 'image');
    Get.defaultDialog(
      title: '',
      backgroundColor: color,
      content: Obx(
        () => isLoadingProfile.value
            ? myLoader()
            : SizedBox(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('$imageURL/${user.image}'),
                    ),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    showText(text: user.userName,textColor: kWhite),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    showText(text: user.country,textColor: kWhite),
                    SizedBox(
                      height: Get.height * .015,
                    ),
                    IconButton(onPressed: (){
                    Get.back();
                    apiController.reportUser(userId: int.parse(userId));
                    Get.snackbar('Thanks'.tr, 'Reported successfully'.tr,);
                    }, icon: const Icon(Icons.report_gmailerrorred,color: kWhite,),),
                    GestureDetector(
                        onTap: (){
                        Get.back();
                        apiController.reportUser(userId: int.parse(userId));
                        Get.snackbar('Thanks'.tr, 'Reported successfully'.tr,);
                        },
                        child: showText(text: 'report',textColor: kWhite,size: 12)),
                  ],
                ),
              ),
      ),
    );
    await apiController.getProfileById(userId: int.parse(userId)).then((value) {
      user = UserModel.fromJson(value.data['data']);
      isLoadingProfile.value = false;
      update();
    });
  }

  Future<dynamic> loadRoomMembers({
    required int roomId,
  }) async {
    List<UserModel> newUsers = [];
    var response = await apiController.getRoomUsers(roomId: roomId);
    response.data['data'].forEach((member) {
      newUsers.add(UserModel.fromJson(member));
    });
    roomMembers = newUsers;
    isLoadingRoomMembers.value = false;
    update();
    Future.delayed(Duration(seconds: 4)).then((value) {
      loadRoomMembers(roomId: roomId);
    });
  }



}

