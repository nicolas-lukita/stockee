import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import 'package:stockee/models/global_quote.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader(
      {Key? key,
      required this.stockName,
      required this.orientation,
      required this.globalQuoteData})
      : super(key: key);
  final String stockName;
  final Orientation orientation;
  final GlobalQuote globalQuoteData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: orientation == Orientation.portrait
          ? <Widget>[
              CustomTextDecorator.stockSymbolText(
                  globalQuoteData.globalQuote.symbol),
              CustomTextDecorator.stockTitleText(stockName, 35),
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
            ]
          : <Widget>[
              CustomTextDecorator.stockSymbolText(
                  globalQuoteData.globalQuote.symbol),
              CustomTextDecorator.stockTitleText(stockName, 35),
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
    );
  }
}
