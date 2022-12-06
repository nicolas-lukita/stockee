import 'package:flutter/material.dart';
import 'package:stockee/helpers/app_colors.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import 'package:stockee/search_page/algolia_search_page.dart';
import '../helpers/demo_mode.dart';
import './watchlist_item_card.dart';

class WatchlistSection extends StatefulWidget {
  const WatchlistSection(
      {Key? key,
      required this.uid,
      required this.watchlist,
      required this.globalQuoteDataList,
      required this.refreshHome})
      : super(key: key);
  final String uid;
  final List watchlist;
  final List globalQuoteDataList;
  final Function() refreshHome;

  @override
  State<WatchlistSection> createState() => _WatchlistSectionState();
}

class _WatchlistSectionState extends State<WatchlistSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomTextDecorator.sectionTitle("Your Watchlist")),
          const SizedBox(
            height: 10,
          ),
          widget.globalQuoteDataList.length != widget.watchlist.length
              ? Center(
                  child: Column(
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Fetching your data...')
                    ],
                  ),
                )
              : widget.watchlist.isEmpty
                  ? Center(
                      child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              AlgoliaSearchPage.routeName, (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Check out stocks ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.teal),
                            ),
                            Icon(Icons.arrow_right_alt_rounded,
                                color: AppColors.teal)
                          ],
                        ),
                      ),
                    ))
                  : Expanded(
                      child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return WatchlistItemCard(
                          uid: widget.uid,
                          stockName: DemoMode.isDemoMode
                              ? widget.watchlist[index]['name']
                              : widget.watchlist.firstWhere((element) =>
                                  element['symbol'] ==
                                  widget.globalQuoteDataList[index].globalQuote
                                      .symbol)['name'],
                          globalQuoteData: widget.globalQuoteDataList[index],
                          refreshHome: widget.refreshHome,
                        );
                      }),
                      itemCount: widget.watchlist.length,
                    )),
        ]);
  }
}
