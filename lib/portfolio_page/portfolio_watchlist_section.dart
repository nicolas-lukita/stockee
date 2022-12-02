import 'package:flutter/material.dart';

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
                    Text(
                      userWatchlist[index]['symbol'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.grey,
                          letterSpacing: 0.5),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userWatchlist[index]['name'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                              Text(
                                '\$' +
                                    globalQuoteDataList[index]
                                        .globalQuote
                                        .price,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    letterSpacing: 0.5),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                globalQuoteDataList[index]
                                    .globalQuote
                                    .changePercent,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    letterSpacing: 0.5),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                globalQuoteDataList[index].globalQuote.change,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                    letterSpacing: 0.5),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
