import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/repositories/books_repository.dart';
import 'package:bibliotrack/repositories/vinyls_repository.dart';
import 'package:bibliotrack/resource/message_scaffold.dart';
import 'package:bibliotrack/repositories/users_repository.dart';
import 'package:bibliotrack/views/mainpage/vinyleDetail.dart';
import 'package:bibliotrack/widget/addingVinylButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/addingBookButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';
import 'package:loading_gifs/loading_gifs.dart';

class VinylePage extends StatefulWidget {
  VinylePage({Key? key}) : super(key: key);

  @override
  State<VinylePage> createState() => _VinylePageState();
}

class _VinylePageState extends State<VinylePage> {
  late List<Discogs> _discogsModel = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    String Page = "Vinyle";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: SingleChildScrollView(
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
                      subtitle: Text(_discogsModel[index].year.toString()),
                      trailing: Text(_discogsModel[index].genre![0].toString()),
                      leading: SizedBox(
                        width: 100,
                        height: 100,
                        child: FadeInImage.assetNetwork(
                            height: 100,
                            width: 100,
                            fadeInDuration: const Duration(seconds: 1),
                            fadeInCurve: Curves.bounceIn,
                            placeholder: circularProgressIndicator,
                            image: _discogsModel[index].coverImage.toString()),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VinylsDetail(
                                  VinylsModel: _discogsModel[index],
                                )));
                      },
                    ));
                  },
                ),
        ),
      ),
      floatingActionButton: addViynylsButton(),
    );
  }
}
