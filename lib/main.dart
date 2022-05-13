import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:bibliotrack/views/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}
