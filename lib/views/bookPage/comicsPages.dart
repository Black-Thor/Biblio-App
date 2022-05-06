import 'dart:convert';
import 'dart:math';

import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/utils/firestore.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ComicsPage extends StatefulWidget {
  ComicsPage({Key? key}) : super(key: key);

  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#00ccbb', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      print(barcodeScanRes);
      _scanBarcode = barcodeScanRes;
    });
    if (_scanBarcode.isNotEmpty && _scanBarcode != "-1") {
      var myInt = int.parse(_scanBarcode);
      assert(myInt is int);

      final FirebaseFirestore _store = FirebaseFirestore.instance;
      FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationHelper().getUid())
          .update({
        "BookBarcode": FieldValue.arrayUnion([myInt])
      }).then((_) {
        print("success!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String Page = "Comics";
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
