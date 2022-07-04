import 'dart:io';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/resource/redirectNavigator.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_gifs/loading_gifs.dart';

class VinylsDetail extends StatefulWidget {
  VinylsDetail({Key? key, index, required this.VinylsModel}) : super(key: key);
  @override
  final Discogs VinylsModel;

  @override
  State<VinylsDetail> createState() => _VinylsDetailState();
}

class _VinylsDetailState extends State<VinylsDetail> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late List<Discogs> _discogsModel = [];

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Detail'),
    const Tab(text: 'Note'),
  ];

  double rating = 0;

  @override
  void initState() {
    super.initState();
    initGetVinyl();
  }

  void initGetVinyl() {
    VinylsRepository()
        .getFrenchVinylsOfUser()
        .then((vinyls) => setState(() => _discogsModel = vinyls))
        .catchError(
            (error) => MessageScaffold().messageToSnackBar(context, error));
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: CustomAppBarDetails(
              widget.VinylsModel.title.toString(), myTabs, context, _key),
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
                      image: widget.VinylsModel.coverImage.toString(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.VinylsModel.country.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.VinylsModel.year.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.VinylsModel.genre.toString(),
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
                      widget.VinylsModel.country.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.VinylsModel.year.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      widget.VinylsModel.genre.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Votre note sur le vinyl est  : ${rating}",
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

  verification() {
    for (int i = 0; i < _discogsModel.length; i++) {
      final vinylbarcode = widget.VinylsModel.barcode![0].replaceAll(' ', '');
      final index1 = _discogsModel[i].barcode?.indexOf(vinylbarcode);
      if (index1 != -1) {
        final index2 = _discogsModel[i]
            .barcode
            ?.indexOf(widget.VinylsModel.barcode![0].replaceAll(' ', ''));
        return _discogsModel[i].barcode![index2 as int];
      }
    }
  }

  // verificationcatno() {
  //   var catno;
  //   widget.VinylsModel.barcode!.forEach((element) {
  //     for (int i = 0; i < _discogsModel.length; i++) {
  //       final index1 = _discogsModel[i].barcode?.indexOf(element);

  //       if (index1 != -1) {
  //         final index2 = _discogsModel[i].barcode?.indexOf(element);
  //         print(_discogsModel[i].barcode![index2 as int]);
  //         catno = _discogsModel[i].barcode![index2 as int];
  //         break;
  //       }
  //     }
  //   });
  //   print("catno $catno");
  // }

  Row detailsButton(context) {
    return Row(
      children: [
        Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              try {
                //  final toDeletecatno = verificationcatno();
                final toDelete = verification();
                print(" $toDelete");
                VinylsRepository().removeVinylBarcode(toDelete).then((_) {
                  MessageScaffold().warningSnackbar(
                      context,
                      "👋 Adieu petit Vinyl",
                      "Ce vinyl à été retirer de votre bibiliothéque");
                });
                Future.delayed(Duration(milliseconds: 3000), () {
                  RedirectTO().RedirectToVinylPage(context);
                });
              } catch (error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${error}')));
              }
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
              onTap: () {},
              child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Marquer comme preter',
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
