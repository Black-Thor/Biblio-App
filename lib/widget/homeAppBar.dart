import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/gestures.dart';
import 'package:bibliotrack/views/user/userPage.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(Page, context, GlobalKey<ScaffoldState> skey, {Key? key})
      : super(
          key: key,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "$Page",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              skey.currentState!.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ],
        );
}

class CustomAppBarDetails extends AppBar {
  CustomAppBarDetails(Page, tabs, context, GlobalKey<ScaffoldState> skey,
      {Key? key})
      : super(
          key: key,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          bottom: TabBar(tabs: tabs),
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "$Page",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ],
        );
}

class CustomAppBarWishlist extends AppBar {
  CustomAppBarWishlist(Page, tabs, context, GlobalKey<ScaffoldState> skey,
      {Key? key})
      : super(
          key: key,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          bottom: TabBar(tabs: tabs),
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "$Page",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              skey.currentState!.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ],
        );
}
