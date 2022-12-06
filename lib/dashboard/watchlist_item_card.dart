import 'package:flutter/material.dart';
import 'package:stockee/details_page/details_screen.dart';
import 'package:stockee/helpers/button_functions.dart';
import 'package:stockee/helpers/demo_mode.dart';
import 'package:stockee/models/global_quote.dart';
import '../helpers/custom_text_decorator.dart';

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
        Navigator.pushNamedAndRemoveUntil(
            context, DetailsScreen.routeName, (route) => false,
            arguments: {
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
                  ? CustomTextDecorator.stockLogo(
                      widget.globalQuoteData.globalQuote.symbol, 25)
                  : const SizedBox(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomTextDecorator.stockTitleText(widget.stockName, 16),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomTextDecorator.stockChangeText(
                              widget.globalQuoteData.globalQuote.change))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomTextDecorator.stockPriceText(
                    widget.globalQuoteData.globalQuote.price),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    disabledColor: Colors.grey,
                    color: Colors.red,
                    onPressed: DemoMode.isDemoMode
                        ? null
                        : () {
                            ButtonFunctions.followButtonFunction(
                                widget.uid,
                                widget.globalQuoteData.globalQuote.symbol,
                                widget.stockName);
                            widget.refreshHome();
                          },
                    icon: const Icon(
                      Icons.delete,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
