import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/helpers/app_colors.dart';
import 'package:stockee/helpers/demo_mode.dart';
import 'package:stockee/home_page/custom_navigation_bar.dart';
import 'package:stockee/home_page/tab_bar_wrapper.dart';
import 'package:stockee/search_page/algolia_search_page.dart';
import 'package:stockee/services/alpha_vantage_api.dart';
import '../models/global_quote.dart';
import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<DocumentSnapshot> userDocStream;

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    userDocStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Stockee",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 35, letterSpacing: 0.5),
          ),
          actions: <Widget>[
            Switch(
                activeColor: AppColors.teal,
                value: DemoMode.isDemoMode,
                onChanged: (newValue) {
                  setState(() {
                    DemoMode.toggleDemoMode();
                  });
                }),
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AlgoliaSearchPage.routeName, (route) => false);
              },
              icon: const Icon(Icons.search),
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
                List userWatchlist =
                    (snapshot.data!.data() as Map)['watchlist'];
                String username = (snapshot.data!.data() as Map)['username'];
                return TabBarWrapper(
                  uid: user.uid,
                  username: username,
                  userWatchlist: userWatchlist,
                  refreshHome: refresh,
                );
              }
              return const Center(child: Text('Database error!'));
            }),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
