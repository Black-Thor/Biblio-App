import 'dart:convert';
import 'dart:math';

import 'package:bibliotrack/utils/firestore.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class ComicsPage extends StatefulWidget {
  ComicsPage({Key? key}) : super(key: key);

  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

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
          Padding(padding: EdgeInsets.only(top: 75)),
          ElevatedButton(
            onPressed: () async {
              CollectionReference users =
                  FirebaseFirestore.instance.collection('users');

              final documents =
                  await users.where("username", isEqualTo: "username").get();
              documents.docs.forEach((element) {
                print(element);
              });
              // documents.docs.forEach((element) {
              //   print(MyClass.fromJson(element.data));
              // });
            },
            child: Text('test'),
          ),
          ElevatedButton(
              onPressed: () {
                CollectionHelper().addUser(uid: "TEST 1", username: "username");
              },
              child: Text('Test 2'))
        ],
      ),
      floatingActionButton: addButton(),
    );
  }
}
