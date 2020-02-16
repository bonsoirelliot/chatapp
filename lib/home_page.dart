import 'package:chatapp/registration_page.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'custom_button.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'HOMESCREEN';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 110.0,
                  height: 100.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Text(
                'Nikitagram',
                style: TitleTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          CustomButton(
            text: "Log In",
            callback: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          CustomButton(
            text: "Register",
            callback: () {
              Navigator.of(context).pushNamed(Registration.id);
            },
          ),
        ],
      ),
    );
  }
}
