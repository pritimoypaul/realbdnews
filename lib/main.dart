import 'package:flutter/material.dart';
import 'package:realbdnews/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "RealBDNews",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}