import 'package:bibliotrack/utils/firebase.dart';
import 'package:bibliotrack/views/bookPage/bookPageDetail.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/services/book_service.dart';
import 'package:loading_gifs/loading_gifs.dart';

class BookPage extends StatefulWidget {
  BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late List<GoogleBooks> _googleBookModel = [];

  @override
  void initState() {
    super.initState();
    _getBook();
    // TODO: implement initState
    super.initState();
    //userInfo si for sidebar data
    AuthenticationHelper().userInfo();
  }

  Future<List<Barcode>> listOfBarcode() async {
    final value = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().getUid())
        .get();
    print("value of instance : ${value.data()!["BookBarcode"]}");
    final barcodes = value.data()!["BookBarcode"] as List<dynamic>;
    return barcodes.map(Barcode.fromDynamic).toList();
  }

  late List testing = [];

  void _getBook() async {
    try {
      final list = await listOfBarcode();
      _googleBookModel = await ApiServiceBook().getFrenchBooks(list);
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error}')));
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String Page = "Livres";

    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: SingleChildScrollView(
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
                          _googleBookModel[index].volumeInfo!.title.toString(),
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
                              imageErrorBuilder: (context, error, StackTrace) {
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BooksDetail(
                                    googleBookModel: _googleBookModel[index],
                                  )));
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: const addButton(),
    );
  }
}
