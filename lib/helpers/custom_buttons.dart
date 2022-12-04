import 'package:flutter/material.dart';

import '../home_page/home_screen.dart';
import 'button_functions.dart';

class CustomButtons {
  static Widget homeButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
        icon: const Icon(Icons.home));
  }

  static Widget followButton(String uid, String symbol, String name,
      bool isFollowed, double fontSize) {
    return ElevatedButton(
      onPressed: () {
        ButtonFunctions.followButtonFunction(uid, symbol, name);
      },
      child: Text(
        isFollowed ? "Unfollow" : "Follow",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            letterSpacing: 0.5),
      ),
      style: ElevatedButton.styleFrom(
        primary: isFollowed ? Colors.grey : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size.fromHeight(
            40), // fromHeight use double.infinity as width and manual the height
      ),
    );
  }
}
