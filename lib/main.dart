import 'package:bibliotrack/views/Login/loginPage.dart';
import 'package:bibliotrack/views/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
