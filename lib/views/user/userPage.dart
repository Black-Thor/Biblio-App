import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/Register/registerPage.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:bibliotrack/utils/firestore.dart';

class ProfilePage extends StatelessWidget {
  @override
  String uid = AuthenticationHelper().getUid().toString();
  String email = UsersRepository().getEmail().toString();
  final profile = [
    'assets/profile/profile1.png',
    'assets/profile/profile2.png',
    'assets/profile/profile3.png',
    'assets/profile/profile4.png',
    'assets/profile/profile5.png',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          UsersRepository().getEmail(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0092A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: GetUserName(uid),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0092A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          AuthenticationHelper().passwordReset(email, context);
                          print("object");
                        },
                        child: const Text(
                          'Reset du mot de passe',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0092A2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("${profile[0]}"),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget textfield({hintText}) {
  return Material(
    elevation: 4,
    shadowColor: Color(0xff0092A2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Color(0xff0092A2),
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none)),
    ),
  );
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff0092A2);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
