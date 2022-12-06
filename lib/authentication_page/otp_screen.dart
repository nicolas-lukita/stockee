import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockee/home_page/home_screen.dart';

import './user_data_screen.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp-screen';
  OtpScreen({Key? key, required this.phoneNumber, required this.verificationId})
      : super(key: key);
  final String phoneNumber;
  final String verificationId;

  String _verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(32),
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
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: verificationId,
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
