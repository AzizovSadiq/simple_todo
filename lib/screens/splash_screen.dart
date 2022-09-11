import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (() => Navigator.push(
      context, MaterialPageRoute(builder: (context)=> HomePageScreen()))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: Center(
          child: Container(
            child: Image.asset('assets/images/todo_image.png'),
          ),
        ));
  }
}
