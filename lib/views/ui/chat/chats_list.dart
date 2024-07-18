import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/chat_provider.dart';
import 'package:jobjunction/models/response/chat/get_chat.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/chat/chat_page.dart';
// import 'package:jobjunction/views/ui/chat/conversation_page.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          child: DrawerWidget(
            color: Color(kDark.value),
          ),
          text: "Chats",
        ),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          chatNotifier.getChats();
          chatNotifier.getPrefs();
          return FutureBuilder<List<GetChats>>(
            future: chatNotifier.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Chat available"),
                );
              } else {
                var data = snapshot.data;

                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 0),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final chat = data[index];
                    final users = chat.users
                        .where((user) => user.id != chatNotifier.userId)
                        .toList();

                    if (users.isEmpty) return SizedBox.shrink();

                    final user = users.first;

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => ConversationPage(
                            title: user.username,
                            user: chat.users.map((u) => u.id).toList(),
                            id: chat.id,
                            profile: user.profile,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 80.h,
                        width: double.infinity,
                        child: ListTile(
                          minLeadingWidth: 0,
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(user.profile),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: user.username,
                                style: appstyle(
                                  16,
                                  Color(kDark.value),
                                  FontWeight.w500,
                                ),
                              ),
                              const HeightSpacer(size: 10),
                              ReusableText(
                                text: chat.latestMessage?.content ?? '',
                                style: appstyle(
                                  16,
                                  Color(kDarkGrey.value),
                                  FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 4.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ReusableText(
                                  text: chatNotifier
                                      .msgTime(chat.updatedAt.toString()),
                                  style: appstyle(
                                    10,
                                    Color(kDark.value),
                                    FontWeight.normal,
                                  ),
                                ),
                                Icon(
                                  chat.chatName == chatNotifier.userId
                                      ? Ionicons.arrow_forward_circle_outline
                                      : Ionicons.arrow_back_circle_outline,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
