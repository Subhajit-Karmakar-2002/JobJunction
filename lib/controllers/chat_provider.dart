import 'package:flutter/material.dart';
import 'package:jobjunction/models/response/chat/get_chat.dart';
import 'package:jobjunction/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  List<String> _online = [];

  List<String> get online => _online;

  set onlineUsers(List<String> online) {
    _online = online;
    notifyListeners();
  }

  bool _typing = false;
  bool get typing => _typing;
  set setTyping(bool newstate) {
    _typing = newstate;
    notifyListeners();
  }

  String? userId;
  getChats() {
    chats = ChatHelper.getConversation();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now();
    DateTime messagetime = DateTime.parse(timestamp);
    if (now.year == messagetime.year &&
        now.month == messagetime.month &&
        now.day == messagetime.day) {
      return DateFormat.Hm().format(messagetime);
    } else if (now.year == messagetime.year &&
        now.month == messagetime.month &&
        now.day - 1 == messagetime.day) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messagetime);
    }
  }
}
