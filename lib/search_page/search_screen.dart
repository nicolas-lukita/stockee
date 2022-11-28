import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/dashboard/watchlist_item_card.dart';

import '../services/firebase_auth_methods.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

Widget SearchBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    color: const Color(0x54FFFFFF),
    child: Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        onChanged: (_) {},
        //controller: searchEditingController,
        // decoration: const InputDecoration(
        //                       label: Text(
        //                         'Your phone number...',
        //                         style: TextStyle(color: Colors.black54),
        //                       ),
        //                       prefixIcon: Icon(
        //                         Icons.call,
        //                         color: Colors.black,
        //                       ),
        //                       border: OutlineInputBorder(),
        //                       focusColor: Colors.black,
        //                       focusedBorder: OutlineInputBorder(
        //                         borderSide: BorderSide(color: Colors.black),
        //                       ),
        //                     ),
        decoration: const InputDecoration(
          hintText: 'Search..',
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderSide: BorderSide(
                color: Colors.black,
              )),
          enabledBorder: OutlineInputBorder(
            gapPadding: 10,
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
        SearchBar(),
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(15),
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return const WatchlistItemCard(isFollowed: false);
          },
          itemCount: 12,
        ))
      ]),
    );
  }
}
