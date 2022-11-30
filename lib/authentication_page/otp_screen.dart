import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockee/dashboard/dash_screen.dart';
import 'package:stockee/home_page/home_screen.dart';
import 'package:stockee/search_page/search_screen.dart';

import './user_data_screen.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  const OtpScreen(
      {Key? key, required this.phoneNumber, required this.verificationId})
      : super(key: key);
  final String phoneNumber;
  final String verificationId;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _verificationCode = '';

  // _verifyPhone() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: widget.phoneNumber,
  //       //will send verification code
  //       codeSent: (String verificationCode, int? resendToken) {
  //         _verificationCode = verificationCode;
  //       },
  //       //will auto-verify (only works on android)
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             print("Logged in successful!");

  //             print(value.additionalUserInfo!.isNewUser);
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => value.additionalUserInfo!.isNewUser
  //                         ? const DashScreen()
  //                         : const SearchScreen()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       //resend code after 180seconds
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         _verificationCode = verificationId;
  //       },
  //       timeout: const Duration(seconds: 120));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Stockee",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: <Widget>[
                  const Text(
                    "Enter your verification code",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    onSubmit: (String value) async {
                      print("OTP SCREEN, PHONENO=" +
                          widget.phoneNumber +
                          " VERIFICATION CODE=" +
                          _verificationCode);
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: value,
                        );
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) => Navigator.pushNamedAndRemoveUntil(
                                context,
                                value.additionalUserInfo!.isNewUser
                                    ? UserDataScreen.routeName
                                    : HomeScreen.routeName,
                                (route) => false));
                      } catch (err) {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Invalid Code'),
                          duration: Duration(seconds: 5),
                        ));
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
