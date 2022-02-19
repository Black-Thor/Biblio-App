import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Column(),
    );
  }
}
