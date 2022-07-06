import 'dart:convert';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/ratingModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/rating_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:bibliotrack/views/mainpage/bookPage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BooksDetail extends StatefulWidget {
  BooksDetail({Key? key, index, required this.googleBookModel})
      : super(key: key);

  final GoogleBooks googleBookModel;

  @override
  State<BooksDetail> createState() => _BooksDetailState();
}

class _BooksDetailState extends State<BooksDetail> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  double _currentSliderValue = 20;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note'),
  ];

  double rating = 0;
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
                    Slider(
                      value: _currentSliderValue,
                      max: 100,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {

                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       FirebaseFirestore.instance
                    //           .collection('Rating')
                    //           .doc("BC31NtPtP4gRaDvt8XusohWM7Yq2")
                    //           .get()
                    //           .then((DocumentSnapshot doc) {
                    //         print(doc.data());
                    //       });
                    //     },
                    //     child: Text("test")),
                    Text(
                      "nombre de page : ${widget.googleBookModel.volumeInfo!.pageCount}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Votre note sur le livre est  : ${rating}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    RatingBar.builder(
                        minRating: 1,
                        itemSize: 46,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4),
                        updateOnDrag: true,
                        itemBuilder: ((context, _) => Icon(Icons.star,
                            color: Theme.of(context).backgroundColor)),
                        onRatingUpdate: (rating) => setState(() {
                              this.rating = rating;
                            })),
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
              BooksRepository()
                  .removeBookBarcode(BookBarcode.fromString(widget
                      .googleBookModel
                      .volumeInfo!
                      .industryIdentifiers![1]
                      .identifier))
                  .then((_) {
                MessageScaffold().warningSnackbar(
                    context,
                    "👋 Adieu petit livre",
                    "Ce livrer à été retirer de votre bibiliothéque");
              });
              Future.delayed(Duration(milliseconds: 3000), () {
                RedirectTO().RedirectToBookPage(context);
              });
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
              onTap: () {},
              child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Marquer comme lu',
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
