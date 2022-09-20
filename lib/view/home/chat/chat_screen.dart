import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/chat_controller.dart';
import 'package:news_app/controllers/text_controller.dart';
import 'package:news_app/models/components/components.dart';

import '../../../models/components/constants.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {Key? key, required this.color, required this.id, required this.roomName})
      : super(key: key);
  final Color color;
  final int id;
  final String roomName;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    return WillPopScope(
      onWillPop: () async {
        await chatController.leaveRoom(id: id);
        return false;
      },
      child: Scaffold(
        key: _key,
        bottomNavigationBar: Container(
          height: Get.height * .1,
          width: Get.width,
          color: kPrimaryColor,
          child: PhysicalModel(
            color: Colors.grey.withOpacity(0.05),
            elevation: 5.0,
            child: CarouselSlider(
              items: sliderData.map((element) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Get.width * .03,
                  ),
                  width: Get.width,
                  height: Get.height * .15,
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
                height: Get.height * .15,
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
        appBar: AppBar(
          backgroundColor: color,
          title: showText(text: roomName, textColor: kWhite),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              chatController.leaveRoom(id: id);
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
          actions: [
            GetBuilder<ChatController>(builder: (controller) {
              return chatController.isLoadingRoomMembers.value
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () async {
                        chatController.isLoadingRoomMembers.value
                            ? null
                            : _key.currentState!.openEndDrawer();
                      },
                      icon: FittedBox(
                        child: Column(
                          children: [
                            const Icon(Icons.supervised_user_circle_rounded,),
                            SizedBox(
                              height: Get.height * .02,
                              width: Get.width * .07,
                              child: FittedBox(
                                child: showText(
                                  text: chatController.roomMembers.length
                                      .toString(),
                                  textColor: kWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }),
          ],
        ),
        endDrawer: Container(
          color: color,
          width: Get.width * .15,
          height: Get.height,
          padding: const EdgeInsets.all(8),
          child: GetBuilder<ChatController>(builder: (controller) {
            return chatController.isLoadingRoomMembers.value
                ? myLoader()
                : ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          chatController.getUserProfile(
                              userId: chatController.roomMembers[index].id
                                  .toString(),
                              color: color);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '$imageURL/${chatController.roomMembers[index].image}'),
                        ),
                      );
                    },
                    itemCount: chatController.roomMembers.length,
                  );
          }),
        ),
        body: GetBuilder<ChatController>(
          initState: (state) {
            chatController.loadMessages(id: id);
            chatController.loadRoomMembers(roomId: id);
          },
          builder: (controller) {
            return DashChat(
              currentUser: chatController.myUser,
              onSend: (newMessage) {
                chatController.insertNewMessage(newMessage: newMessage, id: id);
              },
              messages: chatController.messages,
              inputOptions: InputOptions(
                alwaysShowSend: true,
                inputTextStyle: TextController().getStyle(),
                sendOnEnter: true,

              ),
              messageOptions: MessageOptions(
                  showCurrentUserAvatar: true,

                  onPressAvatar: (user) {
                    chatController.getUserProfile(
                        userId: user.id, color: color);
                  },
              ),

            );
          },
        ),
      ),
    );
  }
}
