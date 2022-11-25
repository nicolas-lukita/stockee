import 'package:flutter/material.dart';
import './watchlist_item_card.dart';

class WatchlistComponent extends StatelessWidget {
  const WatchlistComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Your Watchlist",
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
      Expanded(
          child: ListView.builder(
        padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return const WatchlistItemCard(isFollowed: false);
        },
        itemCount: 6,
      )),
    ]);
  }
}
