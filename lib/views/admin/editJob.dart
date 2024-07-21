import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/request/jobs/create_job.dart';
import 'package:jobjunction/models/request/updateJobModel.dart';
import 'package:jobjunction/models/response/bookmarks/all_bookmark_response.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/helpers/jobs_helper.dart';
import 'package:jobjunction/views/admin/widget/editTextfield.dart';
import 'package:jobjunction/views/admin/widget/textfield.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditJobPage extends StatefulWidget {
  EditJobPage({super.key, required this.Job});
  JobsResponse? Job;

  @override
  State<EditJobPage> createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  TextEditingController title = TextEditingController();

  TextEditingController loc = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController company = TextEditingController();

  TextEditingController salary = TextEditingController();

  TextEditingController period = TextEditingController();

  TextEditingController contract = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    title.text = widget.Job!.title;
    loc.text = widget.Job!.location;
    desc.text = widget.Job!.description;
    company.text = widget.Job!.company;
    salary.text = widget.Job!.salary.toString();
    period.text = widget.Job!.period.toString();
    contract.text = widget.Job!.contract.toString();

    super.initState();
  }

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
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          text: "Update Job",
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
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Consumer<JobsNotifier>(
            builder: (context, jobsNotifier, child) {
              return Column(
                children: [
                  Edittextfield(controller: title, text: 'Title'),
                  Edittextfield(controller: loc, text: 'Location'),
                  Edittextfield(controller: desc, text: 'Description'),
                  Edittextfield(controller: company, text: 'Company'),
                  Edittextfield(controller: salary, text: 'Salary'),
                  Edittextfield(controller: period, text: 'Period'),
                  Edittextfield(controller: contract, text: 'Contract'),
                  const HeightSpacer(size: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is Hiring",
                        style:
                            appstyle(20, Color(kDark.value), FontWeight.w300),
                      ),
                      Switch(
                        value: jobsNotifier.isHiring,
                        onChanged: (value) {
                          jobsNotifier.isHiring = value;
                        },
                      ),
                    ],
                  ),
                  const HeightSpacer(size: 20),
                  GestureDetector(
                    onTap: () async {
                      UpdateJobsRequest model = UpdateJobsRequest(
                        title: title.text,
                        location: loc.text,
                        company: company.text,
                        hiring: jobsNotifier.isHiring,
                        description: desc.text,
                        salary: salary.text,
                        period: period.text,
                        contract: contract.text,
                        imageurl:
                            "https://img.freepik.com/free-vector/colorful-company-logo-template-with-tagline_23-2148802643.jpg",
                        requirements: [
                          "requirements",
                          "requirements",
                          "requirements"
                        ],
                      );

                      Future<bool> response =
                          JobsHelper.updateJobs(model, widget.Job!.id);

                      if (await response) {
                        Get.snackbar(
                          "Job added",
                          "Success",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.green,
                          icon: const Icon(Icons.add_alert),
                        );
                        Get.to(() => const Mainscreen());
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
                      child: const Center(child: Text("Update Job")),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
