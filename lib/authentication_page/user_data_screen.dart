import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockee/search_page/search_screen.dart';
import '../services/firebase_auth_methods.dart';

class UserDataScreen extends StatefulWidget {
  static const routeName = '/user-data-screen';
  const UserDataScreen({Key? key}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  late User _user;

  Future addUserData(String uid, String username) async {
    print("ADD USER DATA" + uid + username);
    Map<String, String> data = {
      "uid": uid,
      "username": username,
    };
    await FirebaseFirestore.instance.collection('users').doc(uid).set(data);
  }

  void _submitUserData() {
    //create new user in firestore
    print("SUBMIT USER DATA" + _user.uid + _username);
    addUserData(_user.uid, _username);
    Navigator.pushNamedAndRemoveUntil(
        context, SearchScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    _user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome to Stockee!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Please input your data",
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
                            decoration: const InputDecoration(
                              label: Text(
                                'Username',
                                style: TextStyle(color: Colors.black54),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                              focusColor: Colors.black,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onChanged: (input) {
                              setState(() {
                                _username = input;
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
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  _username.isNotEmpty
                                      ? _submitUserData()
                                      : null;
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
