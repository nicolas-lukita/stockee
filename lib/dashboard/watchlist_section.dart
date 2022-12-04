import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import '../search_page/search_screen.dart';
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
                              SearchScreen.routeName, (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Check out stocks ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.blue[600]),
                            ),
                            Icon(Icons.arrow_right_alt_rounded,
                                color: Colors.blue[600])
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
                          stockName: widget.watchlist[index]['name'],
                          globalQuoteData: widget.globalQuoteDataList[index],
                          refreshHome: widget.refreshHome,
                        );
                      }),
                      itemCount: widget.watchlist.length,
                    )),
        ]);
  }
}
