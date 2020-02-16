import 'package:flutter/material.dart';
import 'home_page.dart';
import 'registration_page.dart';
import 'login_page.dart';
import 'chat_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      theme: ThemeData(backgroundColor: Colors.blue[100]),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
      },
    );
  }
}
