import 'package:flutter/material.dart';
import './square_info_card.dart';

class GainLoseComponent extends StatelessWidget {
  const GainLoseComponent({Key? key, required this.orientation})
      : super(key: key);
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Gainers and Losers",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[SquareInfoCard(), SquareInfoCard()])
              : Flexible(
                  child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 3,
                    childAspectRatio: 1 / 1,
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    return SquareInfoCard();
                  },
                  itemCount: 2,
                )),
        ]);
  }
}
