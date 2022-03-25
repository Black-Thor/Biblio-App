import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //userInfo si for sidebar data
    userInfo();
  }

  @override
  Widget build(BuildContext context) {
    String Page = "Livres";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 108.0),
        child: Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildCard(),
              SizedBox(
                width: 12,
              ),
              buildCard(),
              SizedBox(
                width: 12,
              ),
              buildCard(),
              SizedBox(
                width: 12,
              ),
              buildCard(),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: addButton(),
    );
  }

  Widget buildCard() => Container(
        width: 200,
        height: 200,
        color: Colors.red,
      );
}
