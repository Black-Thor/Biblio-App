import 'dart:convert';
import 'dart:math';

import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/widget/addingBookButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ComicsPage extends StatefulWidget {
  ComicsPage({Key? key}) : super(key: key);

  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    String Page = "Comics";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Work In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              "Work In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              "Work In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              "Work In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Center(
            child: Text(
              "Work In Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Slider(
              value: _currentSliderValue,
              max: 100,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              })
        ],
      ),
      floatingActionButton: addButtonBook(),
    );
  }
}
