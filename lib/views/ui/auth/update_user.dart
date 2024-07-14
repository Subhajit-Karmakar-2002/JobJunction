import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/custom_btn.dart';
import 'package:jobjunction/views/common/custom_textfield.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
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
        builder: (context, value, child) {
          return ListView(
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
                  CircleAvatar(
                    backgroundColor: Color(kLightBlue.value),
                    child: Center(
                      child: Icon(Icons.photo_filter_rounded),
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 20),
                    ReusableText(
                      text: "Professional Skills",
                      style: appstyle(20, Color(kDark.value), FontWeight.w400),
                    ),
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 10),
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
                    HeightSpacer(size: 20),
                    CustomButton(
                      text: "Update Info",
                      ontap: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
