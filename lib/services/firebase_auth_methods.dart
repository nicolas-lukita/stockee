import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication_page/otp_screen.dart';

class FirebaseAuthMethods {
  FirebaseAuthMethods(this._auth);
  final FirebaseAuth _auth;

  User get user => _auth.currentUser!;

  //auth state getter to listen whenever auth state changes
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> phoneSignIn(BuildContext context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      //will auto handle code (only works on android)
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.message!),
          ),
        );
      },
      //will send verification code
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpScreen(
                    phoneNumber: phoneNumber, verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out function (implement later)
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message!),
        ),
      );
    }
  }
}
