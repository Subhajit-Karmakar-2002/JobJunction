import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.84,
                child: Row(
                  children: [
                    Icon(
                      Feather.search,
                      color: Color(kOrange.value),
                      size: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ReusableText(
                      text: "Search for Job",
                      style: appstyle(
                          20, Color(kLightGrey.value), FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesome.sliders,
                size: 20,
                color: Color(kDarkGrey.value),
              ),
            ],
          ),
          HeightSpacer(size: 7),
          Divider(
            thickness: 1,
            color: Color(kLightGrey.value),
            endIndent: 40.w,
          )
        ],
      ),
    );
  }
}
