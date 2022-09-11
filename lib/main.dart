import 'package:flutter/material.dart';
// import 'package:todo_list_easy/home_page.dart';


import 'screens/home_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpalshScreen(),
      // home: HomePageScreen(),
    );
  }
}