import 'package:flutter/material.dart';
import './dashboard/dash_screen.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const DashScreen(),
    );
  }
}
