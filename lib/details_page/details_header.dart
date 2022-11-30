import 'package:flutter/material.dart';
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
          children: <Widget>[
            Text(
              '\$' + globalQuoteData.globalQuote.price,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black,
                  letterSpacing: 0.5),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              globalQuoteData.globalQuote.changePercent,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.red,
                  letterSpacing: 0.5),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              globalQuoteData.globalQuote.change,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 0.5),
            )
          ],
        )
      ],
    );
  }
}
