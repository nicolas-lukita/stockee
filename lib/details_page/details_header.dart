import 'package:flutter/material.dart';
import 'package:stockee/models/stock_info.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({Key? key, required this.stock}) : super(key: key);
  final StockInfo stock;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          stock.symbol,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.grey,
              letterSpacing: 0.5),
        ),
        Text(
          stock.name,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        Row(
          children: <Widget>[
            Text(
              '\$' + stock.price,
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
              stock.changePercent,
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
              stock.change,
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
