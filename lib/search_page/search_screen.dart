import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/dashboard/watchlist_item_card.dart';
import 'package:stockee/helpers/stock_list_preferences.dart';
import 'package:stockee/search_page/stock_card.dart';
import './search_bar.dart';
import '../services/firebase_auth_methods.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List stockList = [];
  var collectionRef = FirebaseFirestore.instance;
  bool isLoading = false;

  Future getStocksList() async {
    isLoading = true;
    await collectionRef.collection('stocks').get().then((snapshot) {
      snapshot.docs.forEach((stockData) {
        stockList.add(stockData);
      });
    }).then((value) => setState(() {
          isLoading = false;
        }));
  }

  @override
  void initState() {
    getStocksList();
    super.initState();
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
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, DashScreen.routeName, (route) => false);
                },
                icon: const Icon(Icons.home)),
          )
        ],
      ),
      body: Column(children: <Widget>[
        const SearchBar(),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
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
                                symbol: stockList[index]['symbol'],
                                name: stockList[index]['name'],
                                uid: _user.uid,
                                isFollowed: (newList.isNotEmpty &&
                                        newList.contains(
                                            stockList[index]['symbol']))
                                    ? true
                                    : false);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  },
                  itemCount: stockList.length,
                );
              })),
      ]),
    );
  }
}
