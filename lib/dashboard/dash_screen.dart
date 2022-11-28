import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockee/dashboard/gain_lose_component.dart';
import 'package:stockee/dashboard/watchlist_component.dart';
import 'package:stockee/search_page/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:stockee/services/firebase_auth_methods.dart';

class DashScreen extends StatefulWidget {
  static const routeName = '/dash-screen';
  const DashScreen({Key? key}) : super(key: key);

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  // String uid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // uid = FirebaseAuth.instance.currentUser!.uid;
    // print("CURRENT USER ID = " + uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          user.uid,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
              color: Colors.black,
              letterSpacing: 0.5),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
            icon: const Icon(Icons.search),
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  context.read<FirebaseAuthMethods>().signOut(context);
                },
                icon: const Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: OrientationBuilder(builder: (ctx, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  GainLoseComponent(orientation: orientation),
                  const SizedBox(
                    height: 20,
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
