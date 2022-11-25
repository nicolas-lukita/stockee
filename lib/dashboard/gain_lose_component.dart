import 'package:flutter/material.dart';
import './square_info_card.dart';

class GainLoseComponent extends StatelessWidget {
  const GainLoseComponent({Key? key, required this.orientation})
      : super(key: key);
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Gainers and Losers",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    "See all",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue[600]),
                  ),
                  Icon(Icons.arrow_right_alt_rounded, color: Colors.blue[600])
                ],
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[SquareInfoCard(), SquareInfoCard()])
    ]);
  }
}
