import 'package:barcode_widget/barcode_widget.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/views/MainPage/vinylePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class addViynylsButton extends StatefulWidget {
  addViynylsButton({Key? key}) : super(key: key);

  @override
  State<addViynylsButton> createState() => _addButtonState();
}

class _addButtonState extends State<addViynylsButton> {
  String _scanBookBarcode = '';
  final myController = TextEditingController();

  Future<void> scanBarcodeNormal() async {
    String bookbarcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bookbarcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#00ccbb', 'Cancel', true, ScanMode.BARCODE);
      print(bookbarcodeScanRes);
    } on PlatformException {
      bookbarcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBookBarcode = bookbarcodeScanRes;
    });
    if (_scanBookBarcode.isNotEmpty && _scanBookBarcode != "-1") {
      var myInt = int.parse(_scanBookBarcode);
      assert(myInt is int);

      VinylsRepository().addVinylBarcode(myInt);
    }
  }

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 350),
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: const Text('Recherche : '),
                        bottom: const TabBar(
                          indicator: BoxDecoration(color: Color(0xff2D3142)),
                          tabs: <Widget>[
                            Tab(
                              text: 'ISBN ',
                            ),
                            Tab(
                              text: 'par Mot',
                            ),
                            Tab(
                              text: ' Manuelle',
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: myController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    height: 3.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      try {
                                        var myInt =
                                            int.parse(myController.text);
                                        assert(myInt is int);
                                        VinylsRepository()
                                            .addVinylBarcode(myInt);
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Veillez saisir une valeur')));
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ajouter'),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).indicatorColor,
                                        fixedSize: const Size(200, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.camera_alt_outlined),
                                    label: Text('Scan vinyle Code Bar'),
                                    onPressed: () {
                                      scanBarcodeNormal();
                                      Navigator.pushAndRemoveUntil<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  VinylePage()),
                                          ModalRoute.withName('/'));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).indicatorColor,
                                        fixedSize: const Size(200, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextField(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  VinylePage()),
                                          ModalRoute.withName('/'));
                                    },
                                    child: const Text('Recherche'),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).indicatorColor,
                                        fixedSize: const Size(200, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextField(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Recherche'),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).indicatorColor,
                                        fixedSize: const Size(200, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
      child: const Icon(Icons.add),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
