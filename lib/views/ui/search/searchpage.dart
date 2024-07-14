import 'package:flutter/material.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        title: CustomField(
          hintText: "Search",
          controller: search,
          suffixIcon: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/optimized_search.png"),
              ReusableText(
                text: "Start searching for a Job",
                style: appstyle(
                  20,
                  Color(kDark.value),
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
