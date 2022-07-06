import 'package:bibliotrack/repositories/vinyls_repository.dart';

import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';

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
  final isbnController = TextEditingController();
  final catnoController = TextEditingController();
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
    if (_scanBookBarcode.isNotEmpty && _scanBookBarcode != "-1") {
      VinylsRepository().addVinylBarcode(_scanBookBarcode);
    }
  }

  void dispose() {
    isbnController.dispose();
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
                    length: 2,
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
                              text: 'Numero de catalogue',
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
                                          VinylsRepository().addVinylBarcode(
                                              isbnController.text);
                                          Navigator.pop(context);
                                          RedirectTO()
                                              .RedirectToVinylPage(context);
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
                                      try {
                                        await scanBarcodeNormal();
                                        RedirectTO()
                                            .RedirectToVinylPage(context);
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('${error}')));
                                      }
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
                                  controller: catnoController,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    height: 3.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    // onPressed: null,
                                    onPressed: () {
                                      try {
                                        if (catnoController.text.isEmpty) {
                                          MessageScaffold().messageToSnackBar(
                                              context,
                                              "Please Enter some value");
                                        } else {
                                          VinylsRepository().addVinylBarcode(
                                              catnoController.text);
                                          Navigator.pop(context);
                                          RedirectTO()
                                              .RedirectToVinylPage(context);
                                        }
                                      } catch (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('${error}')));
                                      }
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
