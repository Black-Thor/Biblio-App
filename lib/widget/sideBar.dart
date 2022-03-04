import 'dart:io';

import 'package:bibliotrack/views/bookPage/comicsPages.dart';
import 'package:bibliotrack/views/bookPage/bookPage.dart';
import 'package:bibliotrack/views/bookPage/mangaPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSideBar extends StatefulWidget {
  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
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
            accountEmail: Text('example@gmail.com'),
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
            onTap: () => exitApp(),
          ),
        ],
      ),
    );
  }
}

exitApp() {
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else if (Platform.isIOS) {
    exit(0);
  }
}
