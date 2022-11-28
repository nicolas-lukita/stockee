import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/dashboard/watchlist_item_card.dart';
import 'package:stockee/search_page/stock_card.dart';
import './search_bar.dart';
import '../services/firebase_auth_methods.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Stocks",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, DashScreen.routeName, (route) => false);
                },
                icon: const Icon(Icons.home)),
          )
        ],
      ),
      body: Column(children: <Widget>[
        const SearchBar(),
        Expanded(child: OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2,
              childAspectRatio: 1 / 1,
            ),
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return StockCard(
                  symbol: 'NFLX',
                  name: 'Netflixasdfasdfasdfasdfasdfds',
                  isFollowed: false);
            },
            itemCount: 4,
          );
        })),
      ]),
    );
  }
}
