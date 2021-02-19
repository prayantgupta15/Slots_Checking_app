import 'package:flutter/material.dart';
import 'package:khatu/Screens/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContextcontext) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
        buttonColor: Colors.red,
      ),
      home: MainScreen(),
    );
  }
}
