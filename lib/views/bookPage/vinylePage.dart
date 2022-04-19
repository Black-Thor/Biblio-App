import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';


class VinylePage extends StatefulWidget {
  VinylePage({Key? key}) : super(key: key);

  @override
  State<VinylePage> createState() => _VinylePageState();
}

class _VinylePageState extends State<VinylePage> {
final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String Page = "Vinyle";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: Column(
        
      ),
      floatingActionButton: addButton(),
    );
  }
}