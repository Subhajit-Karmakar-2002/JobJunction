import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobjunction/models/request/message/send_message.dart';
import 'package:jobjunction/models/response/chat/get_chat.dart';
import 'package:jobjunction/models/response/chat/initial_message.dart';
import 'package:jobjunction/models/response/message/messaging_response.dart';
import 'package:jobjunction/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingHelper {
  static var client = http.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      ReceivedMessage message =
          ReceivedMessage.fromJson(jsonDecode(response.body));

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessage>> getMessage(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.messagingUrl}/$chatId",
        {"page": offset.toString()});
    var response = await client.get(url, headers: requestHeaders);
    // print(response.body);
    if (response.statusCode == 200) {
      var message = receivedMessageFromJson(response.body);
      return message;
    } else {
      throw Exception("Not able to get message");
    }
  }
}
