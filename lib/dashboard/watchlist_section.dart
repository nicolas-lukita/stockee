import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockee/models/stock_info.dart';
import '../models/global_quote.dart';
import '../search_page/search_screen.dart';
import './watchlist_item_card.dart';

class WatchlistSection extends StatefulWidget {
  const WatchlistSection(
      {Key? key,
      required this.uid,
      required this.watchlist,
      required this.globalQuoteDataList,
      required this.refreshHome})
      : super(key: key);
  final String uid;
  final List watchlist;
  final List globalQuoteDataList;
  final Function() refreshHome;

  @override
  State<WatchlistSection> createState() => _WatchlistSectionState();
}

class _WatchlistSectionState extends State<WatchlistSection> {
  @override
  Widget build(BuildContext context) {
    print("WATCHLIST SECTION BUILD");
    print("==================================================================");
    print(
        "GLOBAL QUOTE LENGTH: " + widget.globalQuoteDataList.length.toString());
    for (var element in widget.globalQuoteDataList) {
      print("GLOBALQUOTE = " + element.globalQuote.symbol.toString());
    }
    print("==================================================================");
    print("==================================================================");
    print("WATCHLIST LENGTH: " + widget.globalQuoteDataList.length.toString());
    for (var element in widget.globalQuoteDataList) {
      print("WATCHLIST = " + element.globalQuote.symbol.toString());
    }
    print("==================================================================");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Your Watchlist",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.globalQuoteDataList.length != widget.watchlist.length
              ? Center(
                  // child: Text("WATCHLIST SECTION LOADING. GLOBALQUOTELENGTH=" +
                  //     widget.globalQuoteDataList.length.toString() +
                  //     "  WATCHLISTLENGTH=" +
                  //     widget.watchlist.length.toString()),
                  child: Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      Text('FETCHING DATA FROM API...')
                    ],
                  ),
                )
              : widget.watchlist.isEmpty
                  ? Center(
                      child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              SearchScreen.routeName, (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Check out stocks ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.blue[600]),
                            ),
                            Icon(Icons.arrow_right_alt_rounded,
                                color: Colors.blue[600])
                          ],
                        ),
                      ),
                    ))
                  : Expanded(
                      child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        //==============================================================
                        // 1. API REQUEST GLOBAL QUOTE FOR EACH ITEM ON WATCHLIST
                        // 2. CONVERT RESPONSE TO MODEL
                        // 3. PASS MODEL TO COMPONENTS
                        // API REQUEST QUOTE ENDPOINT
                        // var sampleResponse = {
                        //   "Global Quote": {
                        //     "01. symbol": "300135.SHZ",
                        //     "02. open": "2.6100",
                        //     "03. high": "2.6600",
                        //     "04. low": "2.5900",
                        //     "05. price": "1696969",
                        //     "06. volume": "7970120",
                        //     "07. latest trading day": "2022-11-29",
                        //     "08. previous close": "2.6100",
                        //     "09. change": "0.0500",
                        //     "10. change percent": "1.9157%"
                        //   }
                        // };
                        // final globalQuoteData =
                        //     globalQuoteFromJson(jsonEncode(sampleResponse));
                        //==============================================================
                        return WatchlistItemCard(
                          uid: widget.uid,
                          stockName: widget.watchlist[index],
                          globalQuoteData: widget.globalQuoteDataList[index],
                          refreshHome: widget.refreshHome,
                        );
                      }),
                      itemCount: widget.watchlist.length,
                    )),
        ]);
  }
}
