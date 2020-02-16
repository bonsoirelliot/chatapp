import 'package:chatapp/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';

class Registration extends StatefulWidget {
  static const String id = 'REGISTRATION';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    AuthResult user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          user: user.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Регистрация ыаыаыа"),
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
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: 'e-mail блятб',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 40.0),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: InputDecoration(
              hintText: 'а сюда пароль',
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(
            text: "Regiser",
            callback: () async {
              registerUser();
            },
          )
        ],
      ),
    );
  }
}
