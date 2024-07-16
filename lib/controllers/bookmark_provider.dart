import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobjunction/models/response/bookmarks/all_bookmark_response.dart';
import 'package:jobjunction/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];

  List<String> get jobs => _jobs;

  Future<List<AllBookMark>>? bookmarks;

  set job(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (jobid != null) {
      _jobs.insert(0, jobid);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> removeJob(String jobid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.remove(jobid);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');
    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookmark(BookmarkReqResModel model, String jobid) {
    BookMarkHelper.addBookmark(model).then((respnse) {
      if (respnse[0]) {
        addJob(jobid);
        Get.snackbar(
          "Bookmark SuccessFully added",
          "Bookmark SuccessFully added",
          colorText: Color(kLight.value),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      } else if (!respnse[0]) {
        Get.snackbar(
          "Failed to load Bookmark",
          "Please try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  deleteBookmark(String jobid) {
    BookMarkHelper.deleteBookmark(jobid).then((respnse) {
      print(respnse);
      if (respnse) {
        removeJob(jobid);
        Get.snackbar(
          "Bookmark removed",
          "Bookmark removed",
          colorText: Color(kLight.value),
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
        );
      } else {
        Get.snackbar(
          "Failed to remove Bookmark",
          "Please try again",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }

  getBookmark() {
    print("Asdasdasdasdasdasdasdasd");
    bookmarks = BookMarkHelper.getBookMarks();
  }
}
