import 'package:barcode_widget/barcode_widget.dart';
import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/resource/convertion.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class addButtonBook extends StatefulWidget {
  addButtonBook({Key? key}) : super(key: key);

  @override
  State<addButtonBook> createState() => _addButtonBookState();
}

class _addButtonBookState extends State<addButtonBook> {
  String _scanBookBarcode = '';
  final isbnController = TextEditingController();
  final AuthorController = TextEditingController();
  final BookNameController = TextEditingController();

  Future<void> scanBarcodeNormal() async {
    String bookbarcodeScanRes;
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
    var hasBarCode = _scanBookBarcode.isNotEmpty && _scanBookBarcode != "-1";
    if (hasBarCode) {
      BooksRepository().addBookBarcodeWithCam(_scanBookBarcode);
    }
  }

  void dispose() {
    isbnController.dispose();
    AuthorController.dispose();
    BookNameController.dispose();
    super.dispose();
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'ISBN ',
    ),
    Tab(
      text: 'mot',
    ),
  ];

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
                    length: myTabs.length,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: const Text('Recherche : '),
                        bottom: TabBar(
                          indicator: BoxDecoration(
                              color: Theme.of(context).indicatorColor),
                          tabs: myTabs,
                        ),
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: isbnController,
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
                                        if (isbnController.text.isEmpty) {
                                          MessageScaffold().messageToSnackBar(
                                              context,
                                              "Please Enter some value");
                                        } else {
                                          BooksRepository().addBookBarcode(
                                              BookBarcode.fromString(
                                                  isbnController.text));
                                          Navigator.pop(context);
                                          RedirectTO()
                                              .RedirectToBookPage(context);
                                        }
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('${error}')));
                                      }
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
                                    label: Text('Scan Code Bar'),
                                    onPressed: () async {
                                      try {
                                        await scanBarcodeNormal();
                                        RedirectTO()
                                            .RedirectToBookPage(context);
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('${error}')));
                                      }
                                    },
                                    //child: const Text('Scan du code bar'),
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
                                TextField(
                                  controller: AuthorController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Auteur',
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: BookNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nom du livre',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: null,
                                    // onPressed: () {
                                    //   String? replaceWhitespacesUsingRegex(
                                    //       String s, String replace) {
                                    //     if (s == null) {
                                    //       return null;
                                    //     }
                                    //     final pattern = RegExp('\\s+');
                                    //     return s.replaceAll(pattern, replace);
                                    //   }

                                    //   String? S1 = replaceWhitespacesUsingRegex(
                                    //       BookNameController.text, '+');
                                    //   String? S2 = replaceWhitespacesUsingRegex(
                                    //       AuthorController.text, '+');

                                    //   BooksRepository()
                                    //       .findBooksByName(S1!, S2!);
                                    // },
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
