import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/home_page/custom_navigation_bar.dart';
import 'package:stockee/home_page/tab_bar_wrapper.dart';
import 'package:stockee/portfolio_page/portfolio_screen.dart';
import 'package:stockee/services/alpha_vantage_api.dart';
import '../models/global_quote.dart';
import '../search_page/search_screen.dart';
import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> userDocStream;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("HOME SCREEN BUILD");
    final _user = context.read<FirebaseAuthMethods>().user;
    userDocStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .snapshots();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _user.uid,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SearchScreen.routeName, (route) => false);
              },
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: () {
                    context.read<FirebaseAuthMethods>().signOut(context);
                  },
                  icon: const Icon(Icons.exit_to_app)),
            )
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: userDocStream,
            builder: (context, snapshot) {
              print("STREAM BUILDER RUNNING");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List userWatchlist =
                    (snapshot.data!.data() as Map)['watchlist'];

                //==========================================================================================
                List globalQuoteDataList = [];
                userWatchlist.forEach(
                  (element) async {
                    var response = await AlphaVantageApi()
                        .getGlobalQuote(element['symbol'])
                        .catchError((err) {
                      //error handling here later
                    });
                    final globalQuote = globalQuoteFromJson(response);
                    globalQuoteDataList.add(globalQuote);
                  },
                );
                //==========================================================================================
                return TabBarWrapper(
                  uid: _user.uid,
                  userWatchlist: userWatchlist,
                  refreshHome: refresh,
                );
              }
              return const Center(child: Text('Database error!'));
            }),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
