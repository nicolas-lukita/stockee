import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stockee/details_page/details_header.dart';
import 'package:stockee/helpers/custom_buttons.dart';
import 'package:stockee/models/global_quote.dart';
import './candlestick_chart.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection(
      {Key? key,
      required this.uid,
      required this.stockName,
      required this.globalQuoteData})
      : super(key: key);
  final String uid;
  final String stockName;
  final GlobalQuote globalQuoteData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userWatchlist = (snapshot.data!.data() as Map)['watchlist'];
            var newList = [...userWatchlist];
            bool isFollowed = (newList.isNotEmpty &&
                    newList.firstWhere(
                            (element) =>
                                element['symbol'] ==
                                globalQuoteData.globalQuote.symbol,
                            orElse: () => null) !=
                        null)
                ? true
                : false;
            return OrientationBuilder(
              builder: (ctx, orientation) {
                return orientation == Orientation.portrait
                    ? Column(
                        children: <Widget>[
                          DetailsHeader(
                            orientation: orientation,
                            stockName: stockName,
                            globalQuoteData: globalQuoteData,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const CandlestickChart(),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButtons.followButton(
                              uid,
                              globalQuoteData.globalQuote.symbol,
                              stockName,
                              isFollowed,
                              25),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  DetailsHeader(
                                    stockName: stockName,
                                    orientation: orientation,
                                    globalQuoteData: globalQuoteData,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomButtons.followButton(
                                      uid,
                                      globalQuoteData.globalQuote.symbol,
                                      stockName,
                                      isFollowed,
                                      25),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const Expanded(flex: 3, child: CandlestickChart()),
                          ],
                        ),
                      );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
