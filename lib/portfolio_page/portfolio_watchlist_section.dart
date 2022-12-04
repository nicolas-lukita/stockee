import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import 'package:stockee/portfolio_page/portfolio_watchlist_card.dart';

import '../details_page/details_screen.dart';
import 'balanced_table.dart';

class PortfolioWatchlistSection extends StatelessWidget {
  const PortfolioWatchlistSection(
      {Key? key,
      required this.uid,
      required this.userWatchlist,
      required this.globalQuoteDataList})
      : super(key: key);
  final String uid;
  final List userWatchlist;
  final List globalQuoteDataList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: CustomTextDecorator.sectionTitle('Your Stocks:'),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: userWatchlist.length,
            itemBuilder: (context, index) {
              return PortfolioWatchlistCard(
                  uid: uid,
                  stockName: userWatchlist[index]['name'],
                  globalQuoteData: globalQuoteDataList[index]);
            },
          ),
        ),
      ],
    );
  }
}
