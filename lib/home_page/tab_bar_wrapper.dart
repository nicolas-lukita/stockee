import 'package:flutter/material.dart';
import 'package:stockee/models/global_quote.dart';
import 'package:stockee/services/alpha_vantage_api.dart';

import '../dashboard/dash_screen.dart';
import '../portfolio_page/portfolio_screen.dart';

class TabBarWrapper extends StatefulWidget {
  const TabBarWrapper(
      {Key? key,
      required this.uid,
      required this.userWatchlist,
      required this.refreshHome})
      : super(key: key);
  final String uid;
  final List userWatchlist;
  final Function() refreshHome;

  @override
  State<TabBarWrapper> createState() => _TabBarWrapperState();
}

class _TabBarWrapperState extends State<TabBarWrapper> {
  List globalQuoteList = [];
  bool isLoading = false;
  List gainLoseData = [];

  Future getGlobalQuoteList() async {
    print("GETGLOBALQUOTE FUNCTION RUN");
    globalQuoteList.clear();
    widget.userWatchlist.forEach((item) {
      print("GGQL FUNCT watchlistlength=" +
          widget.userWatchlist.length.toString());
      setState(() {
        isLoading = true;
      });
      isLoading = true;
      AlphaVantageApi().getGlobalQuote(item['symbol']).then((res) {
        globalQuoteList.insert(0, globalQuoteFromJson(res));
      }).then((value) => setState(() {
            isLoading = false;
          }));
    });
    print("GETGLOBALQUOTE FUNCTION END");
  }

  getGainLoseStock() {
    var gainer = globalQuoteList[0];
    var loser = globalQuoteList[0];
    for (var item in globalQuoteList) {
      if (double.parse(item.globalQuote.change) >
          double.parse(gainer.globalQuote.change)) {
        gainer = item;
      }
      if (double.parse(item.globalQuote.change) <
          double.parse(loser.globalQuote.change)) {
        loser = item;
      }
    }
    return [gainer, loser];
  }

  @override
  void didChangeDependencies() {
    print("TAB BAR DIDCHANGEDEPENDENCY RUN");
    super.didChangeDependencies();
    getGlobalQuoteList().then((value) {
      gainLoseData = getGainLoseStock();
    }).then((value) => setState(() {
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    print("TAB BAR WRAPPER BUILD");
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : TabBarView(children: [
            DashScreen(
              uid: widget.uid,
              userWatchlist: widget.userWatchlist,
              globalQuoteDataList: globalQuoteList,
              refreshHome: widget.refreshHome,
            ),
            PortfolioScreen(
              uid: widget.uid,
              userWatchlist: widget.userWatchlist,
              globalQuoteDataList: globalQuoteList,
            )
          ]);
  }
}
