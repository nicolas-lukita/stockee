import 'package:flutter/material.dart';
import 'package:stockee/helpers/custom_text_decorator.dart';
import '../models/global_quote.dart';

class SquareInfoCard extends StatelessWidget {
  const SquareInfoCard({Key? key, required this.globalQuoteData})
      : super(key: key);
  final GlobalQuote globalQuoteData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CustomTextDecorator.stockLogo(
                globalQuoteData.globalQuote.symbol, 30),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                globalQuoteData.globalQuote.symbol,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CustomTextDecorator.stockPriceText(
              globalQuoteData.globalQuote.price,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomTextDecorator.stockChangePercentText(
                        globalQuoteData.globalQuote.changePercent),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomTextDecorator.stockChangeText(
                        globalQuoteData.globalQuote.change),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
