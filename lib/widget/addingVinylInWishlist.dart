import 'package:barcode_widget/barcode_widget.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddVinylInWishlist extends StatefulWidget {
  AddVinylInWishlist({Key? key}) : super(key: key);

  @override
  State<AddVinylInWishlist> createState() => _AddVinylInWishlistState();
}

class _AddVinylInWishlistState extends State<AddVinylInWishlist> {
  String _scanBookBarcode = '';
  final myController = TextEditingController();

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
      WishlistRepository().addVinylBarcodeWithCam(_scanBookBarcode);
    }
  }

  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Code bare',
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
                          indicator: BoxDecoration(color: Color(0xff2D3142)),
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
                                  keyboardType: TextInputType.number,
                                  controller: myController,
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
                                        if (myController.text.isEmpty) {
                                          MessageScaffold().messageToSnackBar(
                                              context,
                                              "Please Enter some value");
                                        } else {
                                          VinylsRepository()
                                              .addVinylInWishlistBarcode(
                                                  myController.text);

                                          Navigator.pop(context);
                                          RedirectTO()
                                              .RedirectTOWishlistPage(context);
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
                                    label: Text('Scan vinyle Code Bar'),
                                    onPressed: () async {
                                      await scanBarcodeNormal();
                                      RedirectTO()
                                          .RedirectTOWishlistPage(context);
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
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Artiste',
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Album',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: null,
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
      child: const FaIcon(FontAwesomeIcons.recordVinyl),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
