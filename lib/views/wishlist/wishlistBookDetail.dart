import 'dart:async';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:bibliotrack/views/wishlist/wishlist.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class WishlistBooksDetail extends StatefulWidget {
  WishlistBooksDetail({Key? key, index, required this.googleBookModel})
      : super(key: key);

  final GoogleBooks googleBookModel;

  @override
  State<WishlistBooksDetail> createState() => _WishlistBooksDetailState();
}

class _WishlistBooksDetailState extends State<WishlistBooksDetail> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note pour Achat'),
  ];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: CustomAppBarDetails(
              widget.googleBookModel.volumeInfo!.title.toString(),
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
                      widget.googleBookModel.volumeInfo!.title.toString(),
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
                            'https://covers.openlibrary.org/b/isbn/${widget.googleBookModel.volumeInfo!.industryIdentifiers![0].identifier}-L.jpg'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.googleBookModel.volumeInfo!.description.toString(),
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
                      widget.googleBookModel.volumeInfo!.title.toString(),
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
              WishlistRepository()
                  .deleteBookFromWishlist(widget.googleBookModel.volumeInfo!
                      .industryIdentifiers![1].identifier)
                  .then((_) {
                MessageScaffold().warningSnackbar(
                    context,
                    "👋 Adieu petit livre",
                    "Ce livrer à été retirer de votre Wishlist");
              });
              ;
              Future.delayed(Duration(milliseconds: 3000), () {
                RedirectTO().RedirectTOWishlistPage(context);
              });
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Supprimer de la wishlist',
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
                    widget.googleBookModel.volumeInfo!.industryIdentifiers![1]
                        .identifier,
                    context);
                Future.delayed(Duration(milliseconds: 3000), () {
                  // RedirectTO().RedirectTOWishlistPage(context);
                });
              },
              child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "J'ai acheter le livre",
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
