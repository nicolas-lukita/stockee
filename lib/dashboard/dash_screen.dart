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
  const DashScreen(
      {Key? key,
      required this.uid,
      required this.userWatchlist,
      required this.globalQuoteDataList,
      required this.refreshHome})
      : super(key: key);
  final String uid;
  final List userWatchlist;
  final List globalQuoteDataList;
  final Function() refreshHome;

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    print("DASH SCREEN BUILD");
    return OrientationBuilder(builder: (ctx, orientation) {
      return orientation == Orientation.portrait
          ? Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 5,
                  child: GainLoseSection(
                    orientation: orientation,
                    watchlist: widget.userWatchlist,
                    globalQuoteDataList: widget.globalQuoteDataList,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    flex: 5,
                    child: WatchlistSection(
                      uid: widget.uid,
                      watchlist: widget.userWatchlist,
                      globalQuoteDataList: widget.globalQuoteDataList,
                      refreshHome: widget.refreshHome,
                    ))
              ],
            )
          : Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: GainLoseSection(
                      orientation: orientation,
                      watchlist: widget.userWatchlist,
                      globalQuoteDataList: widget.globalQuoteDataList,
                    )),
                Expanded(
                    flex: 6,
                    child: WatchlistSection(
                      uid: widget.uid,
                      watchlist: widget.userWatchlist,
                      globalQuoteDataList: widget.globalQuoteDataList,
                      refreshHome: widget.refreshHome,
                    ))
              ],
            );
    });
  }
}
