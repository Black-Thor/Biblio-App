import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:bibliotrack/views/mainpage/vinylePage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class WishlistVinylsDetail extends StatelessWidget {
  WishlistVinylsDetail({Key? key, index, required this.VinylsModel})
      : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note pour Achat'),
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
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              WishlistRepository()
                  .deleteVinylsFromWishlist(VinylsModel.barcode![0])
                  .then((_) {
                MessageScaffold().warningSnackbar(
                    context,
                    "👋 Adieu petit vinyl",
                    "Ce vinyl à été retirer de votre Wishlist");
              });
              Future.delayed(Duration(milliseconds: 3000), () {
                RedirectTO().RedirectTOWishlistPage(context);
              });
            },
            child: SizedBox(
              height: kToolbarHeight,
              width: 200,
              child: Center(
                child: Text(
                  'Supprimer ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.bold,
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
                WishlistRepository().addVinylBarcode(VinylsModel.barcode![0]);
                WishlistRepository()
                    .deleteVinylsFromWishlist(VinylsModel.barcode![0])
                    .then((_) {
                  MessageScaffold().warningSnackbar(
                      context,
                      "👋 Adieu petit vinyl",
                      "Ce vinyl à été retirer de votre Wishlist");
                });
                Future.delayed(Duration(milliseconds: 3000), () {
                  RedirectTO().RedirectTOWishlistPage(context);
                });
              },
              child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Ajout à la bibliothéque',
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
