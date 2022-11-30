import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockee/models/stock_info.dart';
import '../models/global_quote.dart';
import './watchlist_item_card.dart';

class WatchlistSection extends StatefulWidget {
  const WatchlistSection({
    Key? key,
    required this.uid,
    required this.watchlist,
  }) : super(key: key);
  final String uid;
  final List watchlist;

  @override
  State<WatchlistSection> createState() => _WatchlistSectionState();
}

class _WatchlistSectionState extends State<WatchlistSection> {
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
          child: ListView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          //==============================================================
          // 1. API REQUEST GLOBAL QUOTE FOR EACH ITEM ON WATCHLIST
          // 2. CONVERT RESPONSE TO MODEL
          // 3. PASS MODEL TO COMPONENTS
          // API REQUEST QUOTE ENDPOINT
          var sampleResponse = {
            "Global Quote": {
              "01. symbol": "300135.SHZ",
              "02. open": "2.6100",
              "03. high": "2.6600",
              "04. low": "2.5900",
              "05. price": "1696969",
              "06. volume": "7970120",
              "07. latest trading day": "2022-11-29",
              "08. previous close": "2.6100",
              "09. change": "0.0500",
              "10. change percent": "1.9157%"
            }
          };
          final globalQuoteData =
              globalQuoteFromJson(jsonEncode(sampleResponse));
          //==============================================================
          return WatchlistItemCard(
            uid: widget.uid,
            stockName: widget.watchlist[index],
            globalQuoteData: globalQuoteData,
          );
        }),
        itemCount: widget.watchlist.length,
      )),
    ]);
  }
}
