import 'package:flutter/material.dart';

class JobTextField extends StatelessWidget {
  JobTextField({super.key, required this.controller, this.hintext});
  final hintext;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      // width: double.infinity,
      // height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintext,
        ),
      ),
    );
  }
}
