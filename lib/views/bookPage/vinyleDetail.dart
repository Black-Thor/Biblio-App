import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/bookPage/vinylePage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class VinylsDetail extends StatelessWidget {
  VinylsDetail({Key? key, index, required this.VinylsModel}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note'),
  ];

  @override
  final Discogs VinylsModel;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: CustomAppBarDetails(
              VinylsModel.title.toString(), myTabs, context, _key),
          bottomNavigationBar: detailsButton(context),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    FadeInImage.assetNetwork(
                      height: 250.0,
                      fadeInDuration: const Duration(seconds: 1),
                      fadeInCurve: Curves.bounceIn,
                      fit: BoxFit.cover,
                      placeholder: circularProgressIndicator,
                      image: VinylsModel.coverImage.toString(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      VinylsModel.barcode.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      VinylsModel.country.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      VinylsModel.year.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      VinylsModel.genre.toString(),
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
                      VinylsModel.country.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      VinylsModel.year.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      VinylsModel.genre.toString(),
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
            onTap: () {},
            child: const SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Supprimer ',
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
                _onPressedAdd(VinylsModel.barcode, context);
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
      "barcode": FieldValue.arrayRemove([myInt])
    }).then((_) {
      print("success!");
    });
  }

  void _onPressedAdd(elemets, context) async {
    final FirebaseFirestore_store = FirebaseFirestore.instance;

    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();

    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    var myInt = int.parse(elemets[0]);
    assert(myInt is int);
    
    if (barcodes.contains(elemets)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Already in wish list')));
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(AuthenticationHelper().getUid())
          .update({
        "VinylesWish": FieldValue.arrayUnion([myInt])
      }).then((_) {
        print("success!");
      });
    }
  }
}
