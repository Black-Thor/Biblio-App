import 'dart:convert';
import 'dart:math';

import 'package:bibliotrack/models/bookModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
import 'package:bibliotrack/repositories/wishlist_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/views/mainpage/bookPageDetail.dart';
import 'package:bibliotrack/views/mainpage/vinyleDetail.dart';
import 'package:bibliotrack/views/wishlist/wishlistBookDetail.dart';
import 'package:bibliotrack/views/wishlist/wishlistVinyleDetail.dart';
import 'package:bibliotrack/widget/addingVinylInWishlist.dart';
import 'package:bibliotrack/widget/addingBookButton.dart';
import 'package:bibliotrack/widget/addingBookInWishlist.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:loading_gifs/loading_gifs.dart';

class WishList extends StatefulWidget {
  WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Livres'),
    Tab(text: 'Vinyles'),
  ];
  late List<GoogleBooks> _googleBookModel = [];
  late List<Discogs> _discogsModel = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getBook();
    _getVinyl();
    AuthenticationHelper().userInfo();

    super.initState();
    _tabController =
        TabController(length: myTabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  void _getBook() async {
    try {
      final list =
          await WishlistRepository().getSavedBookInWishlistOfCurrentUser();
      _googleBookModel = await BooksRepository().getFrenchBooks(list);
    } catch (error) {
      MessageScaffold().messageToSnackBar(context, error);
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getVinyl() async {
    try {
      final list = await WishlistRepository().wishedVinylFromBarcode();
      _discogsModel = await VinylsRepository().getFrenchVinyls(list);
    } catch (error) {
      MessageScaffold().messageToSnackBar(context, error);
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
        appBar:
            CustomAppBarWishlist(_tabController, Page, myTabs, context, _key),
        drawer: CustomSideBar(),
        body: TabBarView(
          controller: _tabController,
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WishlistBooksDetail(
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
                                  builder: (context) => WishlistVinylsDetail(
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
        floatingActionButton: _bottomButtons(),
      ),
    );
  }

  Widget _bottomButtons() {
    return _tabController.index == 0
        ? AddBookInWishlist()
        : AddVinylInWishlist();
  }
}
