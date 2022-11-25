import 'package:flutter/material.dart';
import 'package:stockee/dashboard/gain_lose_component.dart';
import 'package:stockee/dashboard/watchlist_component.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Dashboard",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
          )
        ],
      ),
      body: OrientationBuilder(builder: (ctx, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                children: <Widget>[
                  GainLoseComponent(orientation: orientation),
                  const SizedBox(
                    height: 30,
                  ),
                  const Expanded(child: WatchlistComponent())
                ],
              )
            : Row(
                children: <Widget>[
                  Expanded(child: GainLoseComponent(orientation: orientation)),
                  const Expanded(child: WatchlistComponent())
                ],
              );
      }),
    );
  }
}
