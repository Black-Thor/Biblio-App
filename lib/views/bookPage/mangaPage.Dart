import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class MangaPages extends StatefulWidget {
  MangaPages({Key? key}) : super(key: key);

  @override
  State<MangaPages> createState() => _MangaPagesState();
}

class _MangaPagesState extends State<MangaPages> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String Page = "Manga";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: Column(),
      floatingActionButton: addButton(),
    );
  }
}
