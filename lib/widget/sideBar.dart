import 'dart:io';
import 'dart:math';

import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:bibliotrack/views/Register/registerPage.dart';
import 'package:bibliotrack/views/bookPage/comicsPages.dart';
import 'package:bibliotrack/views/bookPage/bookPage.dart';
import 'package:bibliotrack/views/bookPage/mangaPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSideBar extends StatefulWidget {
  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

String? emailReturned;
String? test;
Future userInfo() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      emailReturned = _auth.currentUser?.email;
      print(_auth.currentUser);
    }
  });
  return emailReturned;
}

class _CustomSideBarState extends State<CustomSideBar> {
  // const CustomSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text("${emailReturned}"),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/sidebar.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Livres'),
            onTap: () {
              userInfo();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BookPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('BD / Comics'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ComicsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Manga'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MangaPages()));
            },
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Color.fromARGB(255, 94, 103, 104),
          ),
          ListTile(
            leading: Icon(Icons.wallet_giftcard_rounded),
            title: Text('WhishList'),
            onTap: () => null,
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Color.fromARGB(255, 94, 103, 104),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Color.fromARGB(255, 94, 103, 104),
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              exitApp(context);
              MaterialPageRoute(builder: (context) => LoginPage());
            },
          ),
        ],
      ),
    );
  }
}

exitApp(BuildContext context) async {
  // if (Platform.isAndroid) {
  //   SystemNavigator.pop();
  // } else if (Platform.isIOS) {
  //   exit(0);
  // }
  AuthenticationHelper().signOut().then((result) {
    if (result == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          result,
          style: TextStyle(fontSize: 16),
        ),
      ));
    }
  });
  ;
}
