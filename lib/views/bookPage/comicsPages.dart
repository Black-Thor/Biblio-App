import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/utils/firestore.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/cardScroll.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                var user = await FirebaseAuth.instance.currentUser!;
                var uid = user.uid;
                print(uid);
                collectionHelper().addUser(uid: uid, username: "username");
              },
              child: Text("test 1")),
          ElevatedButton(
              onPressed: () {
                collectionHelper().addUser(uid: "TEST 1", username: "username");
              },
              child: Text('Test 2'))
        ],
      ),
      floatingActionButton: addButton(),
    );
  }
}
