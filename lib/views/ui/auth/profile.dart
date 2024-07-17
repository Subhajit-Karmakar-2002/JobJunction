import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/response/auth/profile_model.dart';
import 'package:jobjunction/services/helpers/auth_helper.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/ui/auth/update_user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required bool drawer});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthHelper.getProfile();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(child: DrawerWidget(color: Color(kDark.value))),
        ),
        body: Consumer<ProfileNotifier>(
          builder: (context, profileNotifier, child) {
            profileNotifier.getProfile();
            return FutureBuilder<ProfileRes>(
                future: profileNotifier.profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  } else {
                    final userdata = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ListView(
                        children: [
                          Container(
                            width: width,
                            height: height * 0.12,
                            color: Color(kLight.value),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image(
                                        width: 80.w,
                                        height: 100.h,
                                        image: const NetworkImage(
                                            "https://wallpapers.com/images/hd/whatsapp-dp-man-in-cap-ucw3kyzqvvuadj33.jpg"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                          text: userdata!.username,
                                          style: appstyle(
                                              20,
                                              Color(kDark.value),
                                              FontWeight.normal),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                                MaterialIcons.location_pin),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ReusableText(
                                              text: userdata!.location,
                                              style: appstyle(
                                                  15,
                                                  Color(kDark.value),
                                                  FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => PersonalDetails());
                                  },
                                  child: const Icon(
                                    Feather.edit,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Stack(
                            children: [
                              Container(
                                color: Color(kLightGrey.value),
                                width: width,
                                height: height * 0.12,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 12.w),
                                      height: 70.h,
                                      width: 60.w,
                                      color: Color(kLight.value),
                                      child: const Icon(
                                        FontAwesome.file_pdf_o,
                                        color: Colors.red,
                                        size: 35,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                            text: "Resume from JobJunction",
                                            style: appstyle(
                                                16,
                                                Color(kDark.value),
                                                FontWeight.w500)),
                                        ReusableText(
                                            text: "JobJunction Resume",
                                            style: appstyle(
                                                14,
                                                Color(kDarkGrey.value),
                                                FontWeight.w500)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 2.h,
                                right: 5.w,
                                child: GestureDetector(
                                  child: ReusableText(
                                      text: "Edit",
                                      style: appstyle(15, Color(kOrange.value),
                                          FontWeight.w500)),
                                ),
                              ),
                            ],
                          ),
                          HeightSpacer(size: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: width,
                            height: height * 0.06,
                            color: Color(kLightGrey.value),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ReusableText(
                                text: userdata!.email,
                                style: appstyle(
                                  14,
                                  Color(kDark.value),
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          HeightSpacer(size: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: width,
                            height: height * 0.06,
                            color: Color(kLightGrey.value),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ReusableText(
                                    text: userdata!.phone,
                                    style: appstyle(
                                      14,
                                      Color(kDark.value),
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HeightSpacer(size: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            width: width,
                            color: Color(kLightGrey.value),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: ReusableText(
                                    text: "Skills",
                                    style: appstyle(
                                      15,
                                      Color(kDark.value),
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                                HeightSpacer(size: 5),
                                SizedBox(
                                  height: height * 0.5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 8.h,
                                    ),
                                    child: Container(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: userdata.skills.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(5),
                                            color: Color(kLight.value),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ReusableText(
                                                text: userdata.skills[index],
                                                style: appstyle(
                                                  15,
                                                  Color(kDark.value),
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                });
          },
        ));
  }
}
