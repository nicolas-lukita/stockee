import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_buttons.dart';
import 'package:stockee/search_page/stock_card.dart';
import '../models/stock_listing.dart';
import './search_bar.dart';
import '../services/firebase_auth_methods.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchText = TextEditingController(text: "");
  var collectionRef = FirebaseFirestore.instance;
  bool isLoading = false;
  // List<StockListing> _stockList = [];
  List _stockList = [];

  //============================================================================
  //  Use for fetching stock listing from firestore database
  //  (currently not in use because of high read request for spark plan)
  //============================================================================
  // Future getStocksList() async {
  //   isLoading = true;
  //   await collectionRef.collection('stocks').get().then((snapshot) {
  //     snapshot.docs.forEach((stockData) {
  //       _stockList.add(stockData);
  //     });
  //   }).then((value) => setState(() {
  //         isLoading = false;
  //       }));
  // }
  //============================================================================

  //============================================================================
  //  Use local asset
  //============================================================================
  Future readStockListing() async {
    setState(() {
      isLoading = true;
    });
    final response = await rootBundle.loadString('assets/stocks.json');
    final stockListing = stockListingFromJson(response);
    setState(() {
      _stockList = stockListing;
      isLoading = false;
    });
  }
  //============================================================================

  @override
  void initState() {
    super.initState();
    //=======================
    //use local asset
    readStockListing();
    //=======================

    //=======================
    //use firestore database
    // getStocksList();
    //=======================
  }

  @override
  Widget build(BuildContext context) {
    final User _user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
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
      body: Column(children: <Widget>[
        SearchBar(
          controller: _searchText,
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Flexible(
                child: OrientationBuilder(builder: (context, orientation) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3,
                    childAspectRatio: 1 / 1,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return StreamBuilder<DocumentSnapshot>(
                        stream: collectionRef
                            .collection('users')
                            .doc(_user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var userWatchlist =
                                (snapshot.data!.data() as Map)['watchlist'];
                            var newList = [...userWatchlist];
                            return StockCard(
                                uid: _user.uid,
                                //=============use firebase database=============
                                // symbol: _stockList[index]['symbol'],
                                // name: _stockList[index]['name'],
                                // isFollowed: (newList.isNotEmpty &&
                                //         newList.firstWhere(
                                //                 (element) =>
                                //                     element['symbol'] ==
                                //                     _stockList[index]['symbol'],
                                //                 orElse: () => null) !=
                                //             null)
                                //     ? true
                                //     : false);

                                //================use local asset================
                                symbol: _stockList[index].symbol,
                                name: _stockList[index].name,
                                isFollowed: (newList.isNotEmpty &&
                                        newList.firstWhere(
                                                (element) =>
                                                    element['symbol'] ==
                                                    _stockList[index].symbol,
                                                orElse: () => null) !=
                                            null)
                                    ? true
                                    : false);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  },
                  itemCount: _stockList.length,
                );
              })),
      ]),
    );
  }
}
