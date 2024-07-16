import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/bookmark_provider.dart';
import 'package:jobjunction/models/response/bookmarks/all_bookmark_response.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/ui/bookmarks/widgets/bookmark_widget.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          child: DrawerWidget(color: Color(kDark.value)),
          text: "BookMark",
        ),
      ),
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookMarkNotifier, child) {
          bookMarkNotifier.getBookmark();
          return FutureBuilder<List<AllBookMark>>(
            future: bookMarkNotifier.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data!.length >= 1) {
                final bookmark = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: bookmark!.length,
                  itemBuilder: (context, index) {
                    return BookMarkWidget(
                      job: bookmark[index].job,
                    );
                    // return Text("Asdasd");
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No Bookmark added",
                    style: appstyle(20, Color(kDark.value), FontWeight.w500),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
