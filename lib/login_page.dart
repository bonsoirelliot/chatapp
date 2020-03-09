import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'custom_button.dart';

class Login extends StatefulWidget {
  static const String id = 'LOGIN';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String uname; //username

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    AuthResult user = await _auth.signInAnonymously();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          username: uname,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    child: CircleAvatar(
                      child: Text(
                        "N",
                        textScaleFactor: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            onChanged: (value) => uname = value,
            decoration: InputDecoration(
              hintText: 'Enter username',
              border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
            ),
          ),
          CustomButton(
            text: "Enter the chat",
            callback: () async {
              await loginUser();
            },
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
