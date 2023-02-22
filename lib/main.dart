import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpt/colors.dart';
import 'package:gpt/home.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGpt',
      home: HomePage(),
    );
  }
}
