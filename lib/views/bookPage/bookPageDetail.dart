import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/views/bookPage/bookPage.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BooksDetail extends StatelessWidget {
  BooksDetail({Key? key, index, required this.googleBookModel})
      : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  final GoogleBooks googleBookModel;
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(
          googleBookModel.volumeInfo!.title.toString(), context, _key),
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
              image:
                  'https://covers.openlibrary.org/b/isbn/${googleBookModel.volumeInfo!.industryIdentifiers![0].identifier}-L.jpg'),
          SizedBox(
            height: 10,
          ),
          Text(
            googleBookModel.volumeInfo!.description.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Row detailsButton(context) {
    return Row(
      children: [
        Material(
          color: const Color(0xffff8989),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
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
}