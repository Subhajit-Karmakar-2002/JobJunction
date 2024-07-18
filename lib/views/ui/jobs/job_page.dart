import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/bookmark_provider.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobjunction/models/request/chat/create_chat.dart';
import 'package:jobjunction/models/request/message/send_message.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/helpers/chat_helper.dart';
import 'package:jobjunction/services/helpers/messaging_helper.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/custom_outline_btn.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetails extends StatefulWidget {
  JobDetails({super.key, this.job});
  JobsResponse? job;
  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          actions: [
            Consumer<BookMarkNotifier>(
              builder: (context, bookMarkNotifier, child) {
                bookMarkNotifier.loadJobs();

                return GestureDetector(
                  onTap: () {
                    if (!bookMarkNotifier.jobs.contains(widget.job!.id)) {
                      BookmarkReqResModel model =
                          BookmarkReqResModel(job: widget.job!.id);
                      bookMarkNotifier.addBookmark(model, widget.job!.id);
                    } else {
                      bookMarkNotifier.deleteBookmark(widget.job!.id);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: !bookMarkNotifier.jobs.contains(widget.job!.id)
                        ? const Icon(Icons.bookmark_border_outlined)
                        : const Icon(Icons.bookmark),
                  ),
                );
              },
            ),
          ],
          text: "Job",
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              children: [
                Container(
                  width: width,
                  height: height * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Color(kLightGrey.value),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/jobs.png"),
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          widget.job!.imageurl,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.job!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.job!.location,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlineBtn(
                              color2: Color(kLight.value),
                              text: widget.job!.contract,
                              color: Color(kOrange.value),
                            ),
                            Text(
                              "${widget.job!.salary}/Monthly",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.job!.description,
                  maxLines: 9,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Requirement:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.job!.requirements.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          widget.job!.requirements[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Consumer<LoginNotifier>(
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: CustomOutlineBtn(
                      onTap: () {
                        CreateChat model =
                            CreateChat(userId: widget.job!.agentId);
                        ChatHelper.apply(model).then((response) {
                          print(response);
                          if (response[0]) {
                            SendMessage model = SendMessage(
                              content:
                                  "Hello, I'm interested in ${widget.job!.title} job you posted in ${widget.job!.location}",
                              chatId: response[1],
                              receiver: widget.job!.agentId,
                            );
                            MessagingHelper.sendMessage(model).whenComplete(() {
                              Get.to(() => Mainscreen());
                            });
                          } else {
                            Get.snackbar("Error", "Something went wrong");
                          }
                        });
                      },
                      height: height * 0.06,
                      text: value.loggedIn ? "Apply" : "Please Login",
                      color: Color(kLight.value),
                      color2: Color(kOrange.value),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
