import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/views/bookPage/vinylePage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class VinylsDetail extends StatelessWidget {
  VinylsDetail({Key? key, index, required this.VinylsModel}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  final Discogs VinylsModel;
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(VinylsModel.title.toString(), context, _key),
      drawer: CustomSideBar(),
      bottomNavigationBar: detailsButton(context),
      body: Column(
        children: [
          FadeInImage.assetNetwork(
            height: 110,
            width: 110,
            fadeInDuration: const Duration(seconds: 1),
            fadeInCurve: Curves.bounceIn,
            fit: BoxFit.fitHeight,
            placeholder: circularProgressIndicator,
            image: VinylsModel.coverImage.toString(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            VinylsModel.country.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            VinylsModel.year.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            VinylsModel.genre.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}

Row detailsButton(context) {
  return Row(
    children: [
      Material(
        color: const Color(0xffff8989),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => VinylePage()));
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: 200,
            child: Center(
              child: Text(
                'Retour en arriére',
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
              //print('called on tap');
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
