import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/authentication_page/login_screen.dart';
import 'package:stockee/authentication_page/user_data_screen.dart';
import 'package:stockee/helpers/app_colors.dart';
import 'package:stockee/home_page/home_screen.dart';
import 'package:stockee/search_page/algolia_search_page.dart';
import 'package:stockee/services/firebase_auth_methods.dart';
import './search_page/search_screen.dart';
import './details_page/details_screen.dart';
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
            scaffoldBackgroundColor: AppColors.lightCream,
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w900)),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black)),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: AppColors.teal),
          ),
          home: const HomeRouter(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            SearchScreen.routeName: (context) => const SearchScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            UserDataScreen.routeName: (context) => const UserDataScreen(),
            DetailsScreen.routeName: (context) => const DetailsScreen(),
            AlgoliaSearchPage.routeName: (context) => const AlgoliaSearchPage(),
          }),
    );
  }
}

//Will send user to home screen if still logged in, to login screen otherwise
class HomeRouter extends StatelessWidget {
  const HomeRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const HomeScreen();
    }
    return LoginScreen();
  }
}
