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
  // Future<List> getGlobalQuoteList(List watchlist) async {
  //   List alist = [];
  //   for (var item in watchlist) {
  //     AlphaVantageApi().getGlobalQuote(item).then((res) {
  //       alist.add(globalQuoteFromJson(res));
  //     });
  //   }
  //   return Future<List>.value([...alist]);
  // }

  List globalQuoteList = [];
  bool isLoading = false;

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
      AlphaVantageApi().getGlobalQuote(item).then((res) {
        globalQuoteList.insert(0, globalQuoteFromJson(res));
      }).then((value) => setState(() {
            isLoading = false;
          }));
    });
    print("GETGLOBALQUOTE FUNCTION END");
  }

  // @override
  // void initState() {
  //   print("TAB BAR INITSTATE RUN");
  //   super.initState();
  //   getGlobalQuoteList().then((value) => setState(() {
  //         isLoading = false;
  //       }));
  // }

  @override
  void didChangeDependencies() {
    print("TAB BAR DIDCHANGEDEPENDENCY RUN");
    super.didChangeDependencies();
    getGlobalQuoteList().then((value) => setState(() {
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
            )
          ]);
  }
}
