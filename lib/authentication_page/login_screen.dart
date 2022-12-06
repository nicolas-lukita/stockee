import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<FirebaseAuthMethods>().phoneSignIn(context, _phoneNumber);
    }
  }

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
                    "Enter your phone number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return "Please enter your phone number!";
                              }
                              if (!input.contains("+")) {
                                return "Please also input your country code!";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text(
                                'Your phone number...',
                                style: TextStyle(color: Colors.black54),
                              ),
                              prefixIcon: Icon(
                                Icons.call,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              focusColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (input) {
                              setState(() {
                                _phoneNumber = input;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                key: const Key('signIn'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  _phoneNumber.isNotEmpty ? _submit() : null;
                                },
                                child: const Text("Next"),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
