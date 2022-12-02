import 'package:flutter/material.dart';
import 'package:stockee/details_page/details_screen.dart';
import 'package:stockee/helpers/button_functions.dart';
import 'package:stockee/models/global_quote.dart';
import 'package:stockee/models/stock_info.dart';

class WatchlistItemCard extends StatefulWidget {
  const WatchlistItemCard({
    Key? key,
    required this.uid,
    required this.stockName,
    required this.globalQuoteData,
    required this.refreshHome,
  }) : super(key: key);
  final String uid;
  final String stockName;
  final GlobalQuote globalQuoteData;
  final Function() refreshHome;

  @override
  State<WatchlistItemCard> createState() => _WatchlistItemCardState();
}

class _WatchlistItemCardState extends State<WatchlistItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: {
          'uid': widget.uid,
          'stockName': widget.stockName,
          'globalQuoteData': widget.globalQuoteData,
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 25,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            widget.globalQuoteData.globalQuote.symbol,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 10,
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.stockName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(widget.globalQuoteData.globalQuote.change))
                  ],
                ),
              ),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.globalQuoteData.globalQuote.price,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {
                      ButtonFunctions.followButtonFunction(widget.uid,
                          widget.globalQuoteData.globalQuote.symbol);
                      widget.refreshHome();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 224, 125, 12),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
