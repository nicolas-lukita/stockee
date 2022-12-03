import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';

import 'balanced_table.dart';

class PortfolioWatchlistSection extends StatelessWidget {
  const PortfolioWatchlistSection(
      {Key? key,
      required this.userWatchlist,
      required this.globalQuoteDataList})
      : super(key: key);
  final List userWatchlist;
  final List globalQuoteDataList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: userWatchlist.length,
      itemBuilder: (context, index) {
        return Card(
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
                      userWatchlist[index]['symbol'],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomTextDecorator.stockTitleText(
                                  userWatchlist[index]['name'], 18),
                              CustomTextDecorator.stockPriceText(
                                  globalQuoteDataList[index].globalQuote.price),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomTextDecorator.stockChangePercentText(
                                globalQuoteDataList[index]
                                    .globalQuote
                                    .changePercent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomTextDecorator.stockChangeText(
                                globalQuoteDataList[index].globalQuote.change,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          child: BalancedTable(listKey: const [
                            "Open",
                            "High",
                            "Low",
                            "Close",
                            "Volume"
                          ], listValue: [
                            globalQuoteDataList[index].globalQuote.open,
                            globalQuoteDataList[index].globalQuote.high,
                            globalQuoteDataList[index].globalQuote.low,
                            globalQuoteDataList[index]
                                .globalQuote
                                .previousClose,
                            globalQuoteDataList[index].globalQuote.volume
                          ]),
                        ),
                      ],
                    ),
                    Container(
                        color: Colors.lightBlue,
                        child: Center(child: Text('BIG CHART')))
                  ],
                ),
              ),
            ));
      },
    );
  }
}
