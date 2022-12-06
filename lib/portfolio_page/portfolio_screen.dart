import 'package:flutter/material.dart';
import 'package:stockee/portfolio_page/portfolio_watchlist_section.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen(
      {Key? key,
      required this.uid,
      required this.username,
      required this.userWatchlist,
      required this.globalQuoteDataList})
      : super(key: key);
  final String uid;
  final String username;
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
                      Expanded(
                          child: PortfolioWatchlistSection(
                        uid: uid,
                        userWatchlist: userWatchlist,
                        globalQuoteDataList: globalQuoteDataList,
                      ))
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Expanded(
                          flex: 6,
                          child: PortfolioWatchlistSection(
                            uid: uid,
                            userWatchlist: userWatchlist,
                            globalQuoteDataList: globalQuoteDataList,
                          ))
                    ],
                  );
          });
  }
}
