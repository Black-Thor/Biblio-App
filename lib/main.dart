import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:bibliotrack/views/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCuRVzxLxw49YmbvjZZn1g__dXw1iMvEAY",
        authDomain:
            "613844981136-9diki3441ejpuo2jhclbumd96cm8ds7a.apps.googleusercontent.com",
        projectId: "biblio-55ca4",
        storageBucket: "biblio-55ca4.appspot.com",
        messagingSenderId: "613844981136",
        appId: "1:613844981136:android:e52bc5d42bab8ee6c78f15"),
  );
  
  final prefs = await SharedPreferences.getInstance();
  final showOnBoard = prefs.getBool('showOnBoard') ?? false;

  runApp(MaterialApp(
    title: "Biblio-Track",
    home: showOnBoard ? LoginPage() : OnboardingPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      primaryColor: Color(0xff1A6F78),
      focusColor: Color.fromARGB(240, 255, 255, 255),
      backgroundColor: Color(0xff0092A2),
      dialogBackgroundColor: Color(0xff25909c),
      dividerColor: Color.fromARGB(255, 94, 103, 104),
      indicatorColor: Color(0xff08363B),
    ),
  ));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(0, 255, 255, 255),
  ));

  await dotenv.load(fileName: ".env");
}
