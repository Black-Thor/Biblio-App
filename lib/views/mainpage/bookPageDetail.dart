import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BooksDetail extends StatelessWidget {
  BooksDetail({Key? key, index, required this.googleBookModel})
      : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GoogleBooks googleBookModel;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note'),
  ];

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
              SingleChildScrollView(
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
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              BooksRepository().removeBookBarcode(googleBookModel
                  .volumeInfo!.industryIdentifiers![1].identifier);
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Supprimer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {
                WishlistRepository().onPressedAddBook(
                    googleBookModel
                        .volumeInfo!.industryIdentifiers![1].identifier,
                    context);
              },
              child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Ajout à la wishlist',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).focusColor,
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
}
