import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockee/dashboard/gain_lose_section.dart';
import 'package:stockee/dashboard/watchlist_section.dart';
import 'package:stockee/search_page/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:stockee/services/firebase_auth_methods.dart';

import '../models/global_quote.dart';

//CHANGE TO STATELESS!!
class DashScreen extends StatefulWidget {
  static const routeName = '/dash-screen';
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  late Stream<DocumentSnapshot> userDocStream;

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    userDocStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          user.uid,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
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
      //stream user's watchlist
      body: StreamBuilder<DocumentSnapshot>(
          stream: userDocStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List userWatchlist = (snapshot.data!.data() as Map)['watchlist'];
              //================================================================

              //================================================================
              return OrientationBuilder(builder: (ctx, orientation) {
                return orientation == Orientation.portrait
                    ? Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                          GainLoseSection(orientation: orientation),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: WatchlistSection(
                            uid: user.uid,
                            watchlist: userWatchlist,
                          ))
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Expanded(
                              child: GainLoseSection(orientation: orientation)),
                          Expanded(
                              child: WatchlistSection(
                                  uid: user.uid, watchlist: userWatchlist))
                        ],
                      );
              });
            }
            return const Center(child: Text('Error: No user data found!'));
          }),
    );
  }
}
