import 'package:flutter/material.dart';
import 'package:tocep/screens/widgets/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      title: 'toCep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ),
  );
}
