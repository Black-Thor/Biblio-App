import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/cardScroll.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class ComicsPage extends StatefulWidget {
  ComicsPage({Key? key}) : super(key: key);

  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String Page = "Comics";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: bookCard(),
      ),
      floatingActionButton: addButton(),
    );
  }
}
