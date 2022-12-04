import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algolia/algolia.dart';
import 'package:provider/provider.dart';
import 'package:stockee/search_page/search_bar.dart';
import 'package:stockee/search_page/stock_card.dart';
import 'package:stockee/services/api_key.dart';

import '../helpers/custom_buttons.dart';
import '../services/firebase_auth_methods.dart';

class AlgoliaSearchPage extends StatefulWidget {
  static const routeName = '/algolia-search-page';
  const AlgoliaSearchPage({Key? key}) : super(key: key);

  @override
  State<AlgoliaSearchPage> createState() => _AlgoliaSearchPageState();
}

class _AlgoliaSearchPageState extends State<AlgoliaSearchPage> {
  TextEditingController _searchText = TextEditingController(text: "");
  var collectionRef = FirebaseFirestore.instance;
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  _search() async {
    setState(() {
      _searching = true;
    });

    Algolia algolia = const Algolia.init(
      applicationId: algoliaAppId,
      apiKey: algoliaKey,
    );

    AlgoliaQuery query = algolia.instance.index('stocks');
    query = query.search(_searchText.text);

    _results = (await query.getObjects()).hits;

    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Stocks",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CustomButtons.homeButton(context),
          )
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SearchBar(
                      controller: _searchText,
                    ),
                  ),
                  IconButton(onPressed: _search, icon: const Icon(Icons.send))
                ],
              ),
            ),
            Expanded(
                child: _searching == true
                    ? const Center(
                        child: Text("Searching..."),
                      )
                    : _results.isEmpty
                        ? const Center(
                            child: Text("No results found..."),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  (MediaQuery.of(context).orientation ==
                                          Orientation.portrait)
                                      ? 2
                                      : 3,
                              childAspectRatio: 1 / 1,
                            ),
                            //itemCount: _results.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              AlgoliaObjectSnapshot snap = _results[index];
                              return StreamBuilder<DocumentSnapshot>(
                                  stream: collectionRef
                                      .collection('users')
                                      .doc(user.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var userWatchlist = (snapshot.data!.data()
                                          as Map)['watchlist'];
                                      var newList = [...userWatchlist];
                                      return StockCard(
                                          uid: user.uid,
                                          symbol: snap.data["symbol"],
                                          name: snap.data["name"],
                                          isFollowed: (newList.isNotEmpty &&
                                                  newList.firstWhere(
                                                          (element) =>
                                                              element[
                                                                  'symbol'] ==
                                                              snap.data[
                                                                  "symbol"],
                                                          orElse: () => null) !=
                                                      null)
                                              ? true
                                              : false);
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  });
                            })

                // : ListView.builder(
                //     itemCount: _results.length,
                //     itemBuilder: (BuildContext ctx, int index) {
                //       AlgoliaObjectSnapshot snap = _results[index];

                //       return ListTile(
                //         leading: CircleAvatar(
                //           child: Text(
                //             (index + 1).toString(),
                //           ),
                //         ),
                //         title: Text(snap.data["symbol"]),
                //         subtitle: Text(snap.data["name"]),
                //       );
                //     },
                //   ),
                ),
          ],
        ),
      ),
    );
  }
}
