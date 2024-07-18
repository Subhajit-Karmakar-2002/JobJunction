import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/chat_provider.dart';
import 'package:jobjunction/models/request/message/send_message.dart';
import 'package:jobjunction/models/response/message/messaging_response.dart';
import 'package:jobjunction/services/config.dart';
import 'package:jobjunction/services/helpers/messaging_helper.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/chat/widget/textField.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:jobjunction/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ConversationPage extends StatefulWidget {
  ConversationPage(
      {super.key,
      required this.title,
      required this.user,
      required this.profile,
      required this.id});
  final String title;
  final String profile;
  final String id;
  final List<String> user;

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late Future<List<ReceivedMessage>> msgList;
  TextEditingController msgcontroller = TextEditingController();
  int offset = 1;
  IO.Socket? socket;
  List<ReceivedMessage> messages = [];
  Set<String> messageIds = {}; // Track message IDs to avoid duplicates
  String receiver = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getMessage(offset);
    connect();
    joinChat();
    handleNext();
  }

  void getMessage(int offset) {
    msgList = MessagingHelper.getMessage(widget.id, offset);
    msgList.then((newMessages) {
      setState(() {
        for (var message in newMessages) {
          if (!messageIds.contains(message.id)) {
            messages.add(message);
            messageIds.add(message.id);
          }
        }
      });
    });
  }

  void handleNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("Loading more messages...");

          if (messages.length >= 12) {
            offset++;
            getMessage(offset);
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io(
      'https://${Config.apiUrl}',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket!.onConnect((_) {
      print('Connect Success');
      socket!.emit('setup', chatNotifier.userId);
      socket!.on('online-users', (userId) {
        chatNotifier.online.replaceRange(
          0,
          chatNotifier.online.length,
          {userId},
        );
      });
    });

    socket!.on('typing', (status) {
      chatNotifier.setTyping = true;
    });
    socket!.on('stop typing', (status) {
      chatNotifier.setTyping = false;
    });

    socket!.on(
      'message received',
      (data) {
        ReceivedMessage receivedMessage = ReceivedMessage.fromJson(data);
        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            if (!messageIds.contains(receivedMessage.id)) {
              messages.add(receivedMessage);
              messageIds.add(receivedMessage.id);
            }
          });
        }
      },
    );

    socket!.connect();
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket!.emit('new message', emission);
      setState(() {
        msgcontroller.clear();
        if (!messageIds.contains(response[1].id)) {
          messages.insert(0, response[1]);
          messageIds.add(response[1].id);
        }
      });
    });
  }

  void sendTypingEvent() {
    socket!.emit('typing', widget.id);
  }

  void sendStopTypingEvent() {
    socket!.emit('stop typing', widget.id);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);

        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: CustomAppBar(
                text: !chatNotifier.typing ? widget.title : "Typing...",
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.profile),
                        ),
                        Positioned(
                          right: 5,
                          child: CircleAvatar(
                            backgroundColor:
                                chatNotifier.online.contains(receiver)
                                    ? Colors.green
                                    : Colors.grey,
                            radius: 5,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                child: GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Get.to(
                        () => const Mainscreen(),
                      );
                    }),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<ReceivedMessage>>(
                        future: msgList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(
                              child: Text("Error"),
                            );
                          } else if (snapshot.data!.isEmpty) {
                            return const searchLoading(
                                text: "You do not have messages");
                          } else {
                            return ListView.builder(
                              reverse: true,
                              controller: _scrollController,
                              itemCount: messages.length,
                              padding: EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 0),
                              itemBuilder: (context, index) {
                                final data = messages[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ReusableText(
                                        text: chatNotifier.msgTime(
                                            data.chat.updatedAt.toString()),
                                        style: appstyle(
                                          10,
                                          Color(kDark.value),
                                          FontWeight.normal,
                                        ),
                                      ),
                                      const HeightSpacer(size: 15),
                                      ChatBubble(
                                        alignment: data.sender.id ==
                                                chatNotifier.userId
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        backGroundColor: data.sender.id ==
                                                chatNotifier.userId
                                            ? Color(kOrange.value)
                                            : Color(kLightBlue.value),
                                        elevation: 0,
                                        clipper: ChatBubbleClipper4(
                                          radius: 8,
                                          type: data.sender.id ==
                                                  chatNotifier.userId
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble,
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                          ),
                                          child: ReusableText(
                                            text: data.content,
                                            style: appstyle(
                                                14,
                                                Color(kLight.value),
                                                FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    MessageTextField(
                      onChanged: (_) {
                        sendTypingEvent();
                      },
                      onEditingComplete: () {
                        String msg = msgcontroller.text;
                        if (msg.isNotEmpty) {
                          sendMessage(msg, widget.id, receiver);
                        }
                      },
                      onSubmitted: (_) {
                        sendStopTypingEvent();
                      },
                      msgcontroller: msgcontroller,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          String msg = msgcontroller.text;
                          if (msg.isNotEmpty) {
                            sendMessage(msg, widget.id, receiver);
                            setState(() {});
                          }
                        },
                        child: const Icon(
                          Icons.send,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }
}
