import 'package:flutter/material.dart';
import 'package:stockee/models/global_quote.dart';
import 'package:stockee/services/alpha_vantage_api.dart';
import '../dashboard/dash_screen.dart';
import '../portfolio_page/portfolio_screen.dart';

class TabBarWrapper extends StatefulWidget {
  const TabBarWrapper(
      {Key? key,
      required this.uid,
      required this.username,
      required this.userWatchlist,
      required this.refreshHome})
      : super(key: key);
  final String uid;
  final String username;
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
    globalQuoteList.clear();
    widget.userWatchlist.forEach((item) {
      setState(() {
        isLoading = true;
      });
      isLoading = true;
      AlphaVantageApi().getGlobalQuote(item['symbol']).then((res) {
        globalQuoteList.add(globalQuoteFromJson(res));
      }).then((value) => setState(() {
            isLoading = false;
          }));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getGlobalQuoteList();
  }

  @override
  Widget build(BuildContext context) {
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
              username: widget.username,
              userWatchlist: widget.userWatchlist,
              globalQuoteDataList: globalQuoteList,
            )
          ]);
  }
}
