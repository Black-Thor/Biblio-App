import 'dart:io';
import 'dart:math';

import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/usecases/sign_out.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/utils/firestore.dart';
import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:bibliotrack/views/mainpage/comicsPages.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:bibliotrack/views/mainpage/vinylePage.dart';
import 'package:bibliotrack/views/wishlist/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSideBar extends StatefulWidget {
  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  // const CustomSideBar({Key? key}) : super(key: key);
  String uid = AuthenticationHelper().getUid().toString();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: GetUserName(uid),
            accountEmail: Text(UsersRepository().getEmail()),
            decoration: const BoxDecoration(
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
              //userInfo();
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
            title: Text('Vinyle'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => VinylePage()));
            },
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            leading: Icon(Icons.wallet_giftcard_rounded),
            title: Text('WhishList'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WishList()));
            },
          ),
          Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Theme.of(context).dividerColor,
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
            color: Theme.of(context).dividerColor,
          ),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              exitApp(context);
              final showOnBoard = await SharedPreferences.getInstance();
              showOnBoard.setBool('showOnBoard', false);
              MaterialPageRoute(builder: (context) => LoginPage());
            },
          ),
        ],
      ),
    );
  }
}

exitApp(BuildContext context) async {

  SignOutUseCase().signOut().then((result) {
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
