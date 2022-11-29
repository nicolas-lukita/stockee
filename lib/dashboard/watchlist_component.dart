import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './watchlist_item_card.dart';

class WatchlistComponent extends StatefulWidget {
  const WatchlistComponent({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<WatchlistComponent> createState() => _WatchlistComponentState();
}

class _WatchlistComponentState extends State<WatchlistComponent> {
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
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                var userWatchlist = (snapshot.data!.data() as Map)['watchlist'];
                var newList = [...userWatchlist];
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return WatchlistItemCard(
                        uid: widget.uid,
                        symbol: newList[index],
                        name: newList[index],
                        price: 'price',
                        change: 'change',
                        changePercent: 'changePercent');
                  }),
                  itemCount: newList.length,
                );
              }
              return const Center(child: Text('Error: No user data found!'));
            }),
      ),
    ]);
  }
}
