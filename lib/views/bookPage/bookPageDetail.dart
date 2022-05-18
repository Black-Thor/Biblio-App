import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/bookPage/bookPage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BooksDetail extends StatelessWidget {
  BooksDetail({Key? key, index, required this.googleBookModel})
      : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note'),
  ];
  final GoogleBooks googleBookModel;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: CustomAppBarDetails(
              googleBookModel.volumeInfo!.title.toString(),
              myTabs,
              context,
              _key),
          bottomNavigationBar: detailsButton(context),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Text(
                      googleBookModel.volumeInfo!.title.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    FadeInImage.assetNetwork(
                        height: 110,
                        width: 110,
                        fadeInDuration: const Duration(seconds: 1),
                        fadeInCurve: Curves.bounceIn,
                        fit: BoxFit.fitHeight,
                        placeholder: circularProgressIndicator,
                        image:
                            'https://covers.openlibrary.org/b/isbn/${googleBookModel.volumeInfo!.industryIdentifiers![0].identifier}-L.jpg'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      googleBookModel.volumeInfo!.description.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      googleBookModel.volumeInfo!.title.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Row detailsButton(context) {
    return Row(
      children: [
        Material(
          color: const Color(0xffff8989),
          child: InkWell(
            onTap: () {
              _onPressedDelete(googleBookModel
                  .volumeInfo!.industryIdentifiers![1].identifier);
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Supprimer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: const Color(0xffff8906),
            child: InkWell(
              onTap: () {
                _onPressedAdd(
                    googleBookModel
                        .volumeInfo!.industryIdentifiers![1].identifier,
                    context);
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Ajout à la wishlist',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onPressedDelete(elemets) {
    var myInt = int.parse(elemets);
    assert(myInt is int);

    final FirebaseFirestore _store = FirebaseFirestore.instance;
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .update({
      "BookBarcode": FieldValue.arrayRemove([myInt])
    }).then((_) {
      print("success!");
    });
  }

  void _onPressedAdd(elemets, context) async {
    final FirebaseFirestore _store = FirebaseFirestore.instance;
    var myInt = int.parse(elemets);
    assert(myInt is int);

    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    final barcodes = value.data()!["BookWish"] as List<dynamic>;

    if (barcodes.contains(myInt)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Already in wish list')));
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationHelper().getUid())
          .update({
        "BookWish": FieldValue.arrayUnion([myInt])
      }).then((_) {
        print("success!");
      });
    }
  }
}
