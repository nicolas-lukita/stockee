import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stockee/dashboard/dash_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _verificationCode = '';

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        //will send verification code
        codeSent: (String verificationCode, int? resendToken) {
          setState(() {
            _verificationCode = verificationCode;
          });
        },
        //function will be called if verification code is correct
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("Logged in successful!");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const DashScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        //resend code after 180seconds
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
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
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: value))
                            .then((value) async {
                          if (value.user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DashScreen()),
                                (route) => false);
                          }
                        });
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
