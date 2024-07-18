import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobjunction/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobjunction/models/response/bookmarks/all_bookmark_response.dart';
import 'package:jobjunction/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/bookmarks/bookmark_res.dart';

class BookMarkHelper {
  static var client = https.Client();

//add bookmark
  static Future<List<dynamic>> addBookmark(BookmarkReqResModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        model.toJson(),
      ),
    );
    if (response.statusCode == 201) {
      String bookmarkid = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkid];
    } else {
      return [false];
    }
  }

//delete bookmark
  static Future<bool> deleteBookmark(String jobid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobid");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<AllBookMark>> getBookMarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var bookmarks = allBookMarkFromJson(response.body);    
      return bookmarks;
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
