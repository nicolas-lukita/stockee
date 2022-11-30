import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/home_page/custom_navigation_bar.dart';
import 'package:stockee/portfolio_page/portfolio_screen.dart';
import '../search_page/search_screen.dart';
import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> userDocStream;

  @override
  Widget build(BuildContext context) {
    final _user = context.read<FirebaseAuthMethods>().user;
    userDocStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Stockee',
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: userDocStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List _userWatchlist = (snapshot.data!.data() as Map)['watchlist'];
              return TabBarView(children: [
                DashScreen(
                  uid: _user.uid,
                  userWatchlist: _userWatchlist,
                ),
                PortfolioScreen(
                  uid: _user.uid,
                  userWatchlist: _userWatchlist,
                )
              ]);
            }
            return const Center(child: Text('Error: No user data found!'));
          }),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
