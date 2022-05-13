import 'package:bibliotrack/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addButton extends StatefulWidget {
  addButton({Key? key}) : super(key: key);

  @override
  State<addButton> createState() => _addButtonState();
}

class _addButtonState extends State<addButton> {
  final myController = TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _addingModalTab(context, myController);
      },
      child: const Icon(Icons.add),
      backgroundColor: Color(0xff0092A2),
    );
  }
}

/**
 * à refacto
 */
_addingModalTab(context, myController) {
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
                  backgroundColor: Color(0xff0092A2),
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
                                var myInt = int.parse(myController.text);
                                assert(myInt is int);
                                _onPressed(myInt);
                                Navigator.pop(context);
                                
                              },
                              child: const Text('Ajouter'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900],
                                  fixedSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Scan du code bar'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[900],
                                  fixedSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
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
                                  primary: Colors.blue[900],
                                  fixedSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
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
                                  primary: Colors.blue[900],
                                  fixedSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
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
}

void _onPressed(data) {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  FirebaseFirestore.instance
      .collection("users")
      .doc(AuthenticationHelper().getUid())
      .update({
    "BookBarcode": FieldValue.arrayUnion([data])
  }).then((_) {
    print("success!");
  });
}
