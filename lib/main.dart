import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/authentication_page/login_screen.dart';
import 'package:stockee/authentication_page/user_data_screen.dart';
import 'package:stockee/services/firebase_auth_methods.dart';
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
    return MultiProvider(
      providers: [
        //Authentication methods provider
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        //Stream authentication state of user
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
          title: 'Stockee',
          theme: ThemeData(
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w900)),
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black)),
            primarySwatch: Colors.blue,
          ),
          //   home: const DetailsScreen(
          //     isFollowed: true,
          //   ),
          // );
          home: const HomeRouter(),
          routes: {
            DashScreen.routeName: (context) => const DashScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            UserDataScreen.routeName: (context) => const UserDataScreen(),
            DetailsScreen.routeName: (context) => const DetailsScreen(),
          }),
    );
  }
}

class HomeRouter extends StatelessWidget {
  const HomeRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const DashScreen();
    }
    return LoginScreen();
  }
}
