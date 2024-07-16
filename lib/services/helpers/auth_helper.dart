import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobjunction/models/request/auth/login_model.dart';
import 'package:jobjunction/models/response/auth/login_res_model.dart';
import 'package:jobjunction/models/response/auth/profile_model.dart';
import 'package:jobjunction/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));
    print(response.body);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> res = json.decode(response.body);

      String token = res['token'];
      String userId = res['_id'];
      String profile = res['profile'];
      print(token);
      await prefs.setString("token", token);
      await prefs.setString("userId", userId);
      await prefs.setString("profile", profile);
      await prefs.setBool("loggedIn", true);

      return true;
    } else {
      print("asdasd");
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.get(url, headers: requestHeaders);
    print(response.body);
    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception("Failed to get the profile");
    }
  }
}
