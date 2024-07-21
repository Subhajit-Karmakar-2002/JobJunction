import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/request/jobs/create_job.dart';
import 'package:jobjunction/services/helpers/jobs_helper.dart';
import 'package:jobjunction/views/admin/widget/textfield.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/ui/homepage.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addjob extends StatefulWidget {
  Addjob({super.key});

  @override
  State<Addjob> createState() => _AddjobState();
}

class _AddjobState extends State<Addjob> {
  TextEditingController title = TextEditingController();

  TextEditingController loc = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController company = TextEditingController();

  TextEditingController salary = TextEditingController();

  TextEditingController period = TextEditingController();

  TextEditingController contract = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    desc.dispose();
    salary.dispose();
    title.dispose();
    loc.dispose();
    company.dispose();
    period.dispose();
    contract.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Add Job",
          child: DrawerWidget(
            color: Color(kDark.value),
          ),
        ),
      ),
      body: Column(
        children: [
          JobTextField(
            controller: title,
            hintext: "Title",
          ),
          JobTextField(
            controller: loc,
            hintext: "Location",
          ),
          JobTextField(
            controller: desc,
            hintext: "Description",
          ),
          JobTextField(
            controller: company,
            hintext: "Company",
          ),
          JobTextField(
            controller: salary,
            hintext: "Salary",
          ),
          JobTextField(
            controller: period,
            hintext: "Period",
          ),
          JobTextField(
            controller: contract,
            hintext: "Contract",
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? userid = prefs.getString('userId');

              CreateJobsRequest model = CreateJobsRequest(
                title: title.text,
                location: loc.text,
                company: company.text,
                hiring: true,
                description: desc.text,
                salary: salary.text,
                period: period.text,
                contract: contract.text,
                imageurl:
                    "https://img.freepik.com/free-vector/colorful-company-logo-template-with-tagline_23-2148802643.jpg",
                agentId: userid!,
                requirements: ["requirements", "requirements", "requirements"],
              );

              Future<bool> response = JobsHelper.createJobs(model);
              if (await response) {
                Get.snackbar(
                  "Job added",
                  "Success",
                  colorText: Color(kLight.value),
                  backgroundColor: Colors.green,
                  icon: const Icon(Icons.add_alert),
                );
                Provider.of<ZoomNotifier>(context, listen: false).currentIndex =
                    0;
                // Get.to(() => Ho());
              } else {
                Get.snackbar(
                  "Job added",
                  "Failed",
                  colorText: Color(kLight.value),
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.add_alert),
                );
              }
              ;
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(color: Colors.orange),
              child: const Center(child: Text("Add Job")),
            ),
          )
        ],
      ),
    );
  }
}
