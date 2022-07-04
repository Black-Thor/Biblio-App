import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
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

class WishlistVinylsDetail extends StatefulWidget {
  WishlistVinylsDetail({Key? key, index, required this.VinylsModel})
      : super(key: key);
  @override
  final Discogs VinylsModel;

  @override
  State<WishlistVinylsDetail> createState() => _WishlistVinylsDetailState();
}

class _WishlistVinylsDetailState extends State<WishlistVinylsDetail> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late List<Discogs> _discogsModel = [];

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Detail'),
    Tab(text: 'Note pour Achat'),
  ];
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
                      widget.VinylsModel.barcode.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  ],
                ),
              ),
            ],
          )),
    );
  }

  verification() {
    print(widget.VinylsModel.barcode![0].replaceAll(' ', ''));
    for (int i = 0; i < _discogsModel.length; i++) {
      final vinylbarcode = widget.VinylsModel.barcode![0].replaceAll(' ', '');
      print(_discogsModel[i].barcode);
      final index1 = _discogsModel[i].barcode?.indexOf(vinylbarcode);
      print(_discogsModel[i].barcode![0]);

      if (index1 != -1) {
        print(
            "Index $index1: ${_discogsModel[i].barcode?.indexOf(widget.VinylsModel.barcode![0].replaceAll(' ', ''))}");
        final index2 = _discogsModel[i]
            .barcode
            ?.indexOf(widget.VinylsModel.barcode![0].replaceAll(' ', ''));
        return _discogsModel[i].barcode![index2 as int];
      }
    }
  }

  Row detailsButton(context) {
    return Row(
      children: [
        Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: () {
              try {
                final toDelete = verification();

                WishlistRepository()
                    .deleteVinylsFromWishlist(toDelete)
                    .then((_) {
                  MessageScaffold().warningSnackbar(
                      context,
                      "👋 Adieu petit vinyl",
                      "Ce vinyl à été retirer de votre Wishlist");
                });
                Future.delayed(Duration(milliseconds: 3000), () {
                  RedirectTO().RedirectTOWishlistPage(context);
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
              onTap: () {
                WishlistRepository()
                    .addVinylBarcode(widget.VinylsModel.barcode![0]);
                WishlistRepository()
                    .deleteVinylsFromWishlist(widget.VinylsModel.barcode![0])
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
