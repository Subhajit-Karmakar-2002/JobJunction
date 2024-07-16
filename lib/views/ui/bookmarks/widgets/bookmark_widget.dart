import 'package:flutter/material.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/bookmark_provider.dart';
import 'package:jobjunction/models/response/bookmarks/all_bookmark_response.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:provider/provider.dart';

class BookMarkWidget extends StatelessWidget {
  BookMarkWidget({super.key, this.job});
  Job? job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: job?.imageurl != null
                      ? NetworkImage(job!.imageurl)
                      : const AssetImage('assets/images/jobs.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: job?.company ?? 'Unknown Company',
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ReusableText(
                      text: job?.title ?? 'Unknown Title',
                      style: appstyle(16, Colors.grey[800]!, FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 5),
                        ReusableText(
                          text: job?.location ?? 'Unknown Location',
                          style: appstyle(
                              14, Colors.grey[700]!, FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                Consumer<BookMarkNotifier>(
                  builder: (context, bookMarkNotifier, child) {
                    return GestureDetector(
                      onTap: () {
                        bookMarkNotifier.deleteBookmark(job!.id);
                      },
                      child: Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
