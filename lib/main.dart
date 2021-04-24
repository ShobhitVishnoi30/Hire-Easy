import 'package:flutter/material.dart';

import 'Authentication/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hire Easy',
      theme: ThemeData(
       brightness: Brightness.light,
          primaryColor: Colors.indigo,
          fontFamily: 'BeVietnam',
          textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.red[800],
          ),
      ),
      home: LoginPage(),
    );
  }
}
