import 'package:capstone_cv/home_page.dart';
import 'package:capstone_cv/text_extract.dart';
import 'package:capstone_cv/text_result.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: Details(),
      home: HomePage(),
    );
  }
}
