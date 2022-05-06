import 'dart:convert';
import 'dart:math';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/services/book_service.dart';
import 'package:bibliotrack/services/vinyle_service.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/utils/firestore.dart';
import 'package:bibliotrack/views/bookPage/bookPageDetail.dart';
import 'package:bibliotrack/views/bookPage/vinyleDetail.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:loading_gifs/loading_gifs.dart';

class WishList extends StatefulWidget {
  WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Livres'),
    Tab(text: 'Vinyles'),
  ];
  late List<GoogleBooks> _googleBookModel = [];
  late List<Discogs> _discogsModel = [];

  @override
  void initState() {
    super.initState();
    _getBook();
    _getVinyl();
    //userInfo si for sidebar data
    AuthenticationHelper().userInfo();
  }

  Future<List<BookBarcode>> listOfBookBarcode() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance : ${value.data()!["BookWish"]}");
    final barcodes = value.data()!["BookWish"] as List<dynamic>;
    return barcodes.map(BookBarcode.fromDynamic).toList();
  }

  void _getBook() async {
    final list = await listOfBookBarcode();
    try {
      _googleBookModel = await ApiServiceBook().getFrenchBooks(list);
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error}')));
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<List<Barcode>> listOfBarcode() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance vinyles: ${value.data()!["VinylesWish"]}");

    final barcodes = value.data()!["VinylesWish"] as List<dynamic>;
    return barcodes.map(Barcode.fromDynamic).toList();
  }

  void _getVinyl() async {
    try {
      final list = await listOfBarcode();
      _discogsModel = await ApiServiceVinyle().getFrenchVinyls(list);
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error}')));
    }

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String Page = "WishList";
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        key: _key,
        appBar: CustomAppBarWishlist(Page, myTabs, context, _key),
        drawer: CustomSideBar(),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _googleBookModel == null || _googleBookModel.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _googleBookModel.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                _googleBookModel[index]
                                    .volumeInfo!
                                    .title
                                    .toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Text(_googleBookModel[index]
                                  .volumeInfo!
                                  .authors!
                                  .first
                                  .toString()),
                              trailing: Text(_googleBookModel[index]
                                  .volumeInfo!
                                  .publishedDate
                                  .toString()),
                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: FadeInImage.assetNetwork(
                                    height: 110,
                                    width: 110,
                                    fadeInDuration: const Duration(seconds: 1),
                                    fadeInCurve: Curves.bounceIn,
                                    fit: BoxFit.fitHeight,
                                    imageErrorBuilder:
                                        (context, error, StackTrace) {
                                      return const Image(
                                          height: 100,
                                          width: 100,
                                          image: AssetImage(
                                              'assets/onboarding/onboard02.png'));
                                    },
                                    placeholder: circularProgressIndicator,
                                    image:
                                        'https://covers.openlibrary.org/b/isbn/${_googleBookModel[index].volumeInfo!.industryIdentifiers![0].identifier}-L.jpg'),
                              ),
                              onLongPress: () {
                                String? test = _googleBookModel[index]
                                    .volumeInfo!
                                    .industryIdentifiers![1]
                                    .identifier;
                                var myInt = int.parse(test!);
                                assert(myInt is int);
                                _onPressedDelete(myInt);
                              },
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BooksDetail(
                                          googleBookModel:
                                              _googleBookModel[index],
                                        )));
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _discogsModel == null || _discogsModel.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _discogsModel.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(
                              _discogsModel[index].title.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle:
                                Text(_discogsModel[index].year.toString()),
                            trailing:
                                Text(_discogsModel[index].genre![0].toString()),
                            leading: SizedBox(
                              width: 100,
                              height: 100,
                              child: FadeInImage.assetNetwork(
                                  height: 100,
                                  width: 100,
                                  fadeInDuration: const Duration(seconds: 1),
                                  fadeInCurve: Curves.bounceIn,
                                  placeholder: circularProgressIndicator,
                                  image: _discogsModel[index]
                                      .coverImage
                                      .toString()),
                            ),
                            onLongPress: () {},
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VinylsDetail(
                                        VinylsModel: _discogsModel[index],
                                      )));
                            },
                          ));
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedDelete(elemets) {
    print(elemets.runtimeType);
    final FirebaseFirestore _store = FirebaseFirestore.instance;
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .update({
      "BookWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      print("success!");
    });
  }

  void _onPressedDeleteVinyls(elemets) {
    print(elemets.runtimeType);
    final FirebaseFirestore _store = FirebaseFirestore.instance;
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .update({
      "VinylesWish": FieldValue.arrayRemove([elemets])
    }).then((_) {
      print("success!");
    });
  }
}
