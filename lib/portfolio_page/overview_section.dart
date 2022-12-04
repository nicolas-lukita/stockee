import 'package:flutter/material.dart';
import 'package:stockee/portfolio_page/overview_card.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection(
      {Key? key, required this.globalQuoteDataList, required this.username})
      : super(key: key);
  final List globalQuoteDataList;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text("Portfolio"),
        OverviewCard(username: username)
      ],
    );
  }
}
