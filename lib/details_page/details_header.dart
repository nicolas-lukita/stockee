import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import 'package:stockee/models/global_quote.dart';
import 'package:stockee/models/stock_info.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader(
      {Key? key, required this.stockName, required this.globalQuoteData})
      : super(key: key);
  final String stockName;
  final GlobalQuote globalQuoteData;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            globalQuoteData.globalQuote.symbol,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.grey,
                letterSpacing: 0.5),
          ),
          Text(
            stockName,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomTextDecorator.stockPriceText(
                globalQuoteData.globalQuote.price,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomTextDecorator.stockChangePercentText(
                globalQuoteData.globalQuote.changePercent,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomTextDecorator.stockChangeText(
                  globalQuoteData.globalQuote.change)
            ],
          )
        ],
      );
    });
  }
}
