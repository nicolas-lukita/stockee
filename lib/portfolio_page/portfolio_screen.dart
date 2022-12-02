import 'package:flutter/material.dart';
import 'package:stockee/portfolio_page/balanced_table.dart';
import 'package:stockee/portfolio_page/portfolio_watchlist_section.dart';

import 'overview_section.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen(
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
    return globalQuoteDataList.length != userWatchlist.length
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : OrientationBuilder(builder: (ctx, orientation) {
            return orientation == Orientation.portrait
                ? Column(
                    children: <Widget>[
                      OverviewSection(),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: PortfolioWatchlistSection(
                        userWatchlist: userWatchlist,
                        globalQuoteDataList: globalQuoteDataList,
                      ))
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Expanded(flex: 4, child: OverviewSection()),
                      Expanded(
                          flex: 6,
                          child: PortfolioWatchlistSection(
                            userWatchlist: userWatchlist,
                            globalQuoteDataList: globalQuoteDataList,
                          ))
                    ],
                  );
          });
  }
}
