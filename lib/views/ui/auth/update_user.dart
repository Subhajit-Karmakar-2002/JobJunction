import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/request/auth/profile_update_model.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/custom_btn.dart';
import 'package:jobjunction/views/common/custom_textfield.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:jobjunction/views/ui/search/widgets/custom_field.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child) {
          return Form(
            key: loginNotifier.profileFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 60.h,
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Personal Details",
                      style: appstyle(35, Color(kDark.value), FontWeight.w500),
                    ),
                    Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                        return imageUploader.imageFil.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  imageUploader.pickImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  child: const Center(
                                    child: Icon(
                                      Icons.photo_filter,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  imageUploader.imageFil.clear();
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(kLightBlue.value),
                                  backgroundImage: FileImage(
                                    File(
                                      imageUploader.imageFil[0],
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    children: [
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: location,
                        hintText: "Location",
                        keyboardType: TextInputType.text,
                        validator: (location) {
                          if (location!.isEmpty) {
                            return "Please enter your location";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: phone,
                        hintText: "Phone",
                        keyboardType: TextInputType.phone,
                        validator: (phone) {
                          if (phone!.isEmpty) {
                            return "Please enter your phone no";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 20),
                      ReusableText(
                        text: "Professional Skills",
                        style:
                            appstyle(20, Color(kDark.value), FontWeight.w400),
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill0,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill) {
                          if (skill!.isEmpty) {
                            return "Please enter your skill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill1,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill) {
                          if (skill!.isEmpty) {
                            return "Please enter your skill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill2,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill) {
                          if (skill!.isEmpty) {
                            return "Please enter your skill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill3,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill) {
                          if (skill!.isEmpty) {
                            return "Please enter your skill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 10),
                      CustomTextField(
                        controller: skill4,
                        hintText: "Professional Skill",
                        keyboardType: TextInputType.text,
                        validator: (skill) {
                          if (skill!.isEmpty) {
                            return "Please enter your skill";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const HeightSpacer(size: 20),
                      CustomButton(
                        text: "Update Info",
                        ontap: () {
                          ProfileUpdateReq model = ProfileUpdateReq(
                              location: location.text,
                              phone: phone.text,
                              profile: "",
                              skills: [
                                skill0.text,
                                skill1.text,
                                skill2.text,
                                skill3.text,
                                skill4.text
                              ]);
                       
                          loginNotifier.updateProfile(model);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
