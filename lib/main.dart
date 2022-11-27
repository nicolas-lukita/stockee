import 'package:flutter/material.dart';
import 'package:stockee/authentication_page/login_screen.dart';
import './search_page/search_screen.dart';
import './dashboard/dash_screen.dart';
import './details_page/details_screen.dart';
import 'dummy_data/test_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase project
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stockee',
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w900)),
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
          primarySwatch: Colors.blue,
        ),
        //   home: const DetailsScreen(
        //     isFollowed: true,
        //   ),
        // );
        home: LoginScreen());
  }
}
