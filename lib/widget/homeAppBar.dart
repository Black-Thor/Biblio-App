import 'package:flutter/gestures.dart';
import 'package:bibliotrack/views/user/userPage.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(context, {Key? key})
      : super(
          key: key,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Color(0xff0092A2),
          title: Text(
            "Bienvenue $context",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => null,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => null,
            ),
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
