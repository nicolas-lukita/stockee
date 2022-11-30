import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockee/models/stock_info.dart';
import '../helpers/converters/global_quote.dart';
import './watchlist_item_card.dart';

class WatchlistComponent extends StatefulWidget {
  const WatchlistComponent({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<WatchlistComponent> createState() => _WatchlistComponentState();
}

class _WatchlistComponentState extends State<WatchlistComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Your Watchlist",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    "See all",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue[600]),
                  ),
                  Icon(Icons.arrow_right_alt_rounded, color: Colors.blue[600])
                ],
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                var userWatchlist = (snapshot.data!.data() as Map)['watchlist'];
                var newList = [...userWatchlist];
                //==============================================================
                // API REQUEST QUOTE ENDPOINT
                var sampleResponse = {
                  "Global Quote": {
                    "01. symbol": "300135.SHZ",
                    "02. open": "2.6100",
                    "03. high": "2.6600",
                    "04. low": "2.5900",
                    "05. price": "2.660320",
                    "06. volume": "7970120",
                    "07. latest trading day": "2022-11-29",
                    "08. previous close": "2.6100",
                    "09. change": "0.0500",
                    "10. change percent": "1.9157%"
                  }
                };
                final globalQuote =
                    globalQuoteFromJson(jsonEncode(sampleResponse));
                //==============================================================
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return WatchlistItemCard(
                      uid: widget.uid,
                      stockData: StockInfo(
                        symbol: newList[index],
                        name: newList[index],
                        open: globalQuote.globalQuote.open,
                        high: globalQuote.globalQuote.high,
                        low: globalQuote.globalQuote.low,
                        price: globalQuote.globalQuote.price,
                        volume: globalQuote.globalQuote.volume,
                        previousClose: globalQuote.globalQuote.previousClose,
                        change: globalQuote.globalQuote.change,
                        changePercent: globalQuote.globalQuote.changePercent,
                        latestTradingDay:
                            globalQuote.globalQuote.latestTradingDay,
                      ),
                    );
                  }),
                  itemCount: newList.length,
                );
              }
              return const Center(child: Text('Error: No user data found!'));
            }),
      ),
    ]);
  }
}
