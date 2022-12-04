import 'package:flutter/material.dart';

import '../details_page/details_screen.dart';
import '../helpers/custom_text_decorator.dart';
import '../models/global_quote.dart';
import 'balanced_table.dart';

class PortfolioWatchlistCard extends StatelessWidget {
  const PortfolioWatchlistCard(
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: {
          'uid': uid,
          'stockName': stockName,
          'globalQuoteData': globalQuoteData,
        });
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextDecorator.stockSymbolText(
                    globalQuoteData.globalQuote.symbol,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTextDecorator.stockTitleText(stockName, 18),
                            CustomTextDecorator.stockPriceText(
                                globalQuoteData.globalQuote.price),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTextDecorator.stockChangePercentText(
                              globalQuoteData.globalQuote.changePercent,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomTextDecorator.stockChangeText(
                              globalQuoteData.globalQuote.change,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: BalancedTable(listKey: const [
                          "Open",
                          "High",
                          "Low",
                          "Close",
                          "Volume"
                        ], listValue: [
                          globalQuoteData.globalQuote.open,
                          globalQuoteData.globalQuote.high,
                          globalQuoteData.globalQuote.low,
                          globalQuoteData.globalQuote.previousClose,
                          globalQuoteData.globalQuote.volume
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
