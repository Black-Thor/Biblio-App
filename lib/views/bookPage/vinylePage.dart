import 'package:bibliotrack/models/userModel.dart';
import 'package:bibliotrack/models/vinyleModel.dart';
import 'package:bibliotrack/services/api_service.dart';
import 'package:bibliotrack/services/vinyle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bibliotrack/widget/addingButton.dart';
import 'package:bibliotrack/widget/homeAppBar.dart';
import 'package:bibliotrack/widget/sideBar.dart';

class VinylePage extends StatefulWidget {
  VinylePage({Key? key}) : super(key: key);

  @override
  State<VinylePage> createState() => _VinylePageState();
}

class _VinylePageState extends State<VinylePage> {
  late List<UserModel>? _userModel = [];
  late List<Discogs>? _discogsModel = [];

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getData();
    _getVinyl();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getVinyl() async {
    _discogsModel = (await ApiServiceV().getFrenchVinyls());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String Page = "Vinyle";
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(Page, context, _key),
      drawer: CustomSideBar(),
      body: _discogsModel == null || _discogsModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _discogsModel!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            _discogsModel![index].coverImage.toString(),
                            scale: 5,
                            alignment: Alignment.centerLeft,
                          ),
                          Column(
                            children: [
                              Text(
                                _discogsModel![index].title.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(_discogsModel![index].year.toString()),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: const addButton(),
    );
  }
}
