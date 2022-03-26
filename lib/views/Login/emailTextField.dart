import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  TextEditingController controller;

  EmailTextField({Key? key, required this.controller}) : super(key: key);
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: "your@email.com"),
    );
  }
}
