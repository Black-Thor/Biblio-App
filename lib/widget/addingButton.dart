import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addButton extends StatelessWidget {
  const addButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _addingModalTab(context);
      },
      child: const Icon(Icons.add),
      backgroundColor: Color(0xff0092A2),
    );
  }
}

_addingModalTab(context) {
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
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 15.0,
                              height: 3.0,
                            ),
                          ),
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
