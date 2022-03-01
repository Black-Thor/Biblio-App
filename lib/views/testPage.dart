import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class testPage extends StatefulWidget {
  testPage({Key? key}) : super(key: key);

  @override
  State<testPage> createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appBar"),
      ),
      body: Column(),
      //drawer: CustomSideBar(),
    );
  }
}
