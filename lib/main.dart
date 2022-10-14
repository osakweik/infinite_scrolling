import 'package:flutter/material.dart';
import 'package:infinite_scrolling/routes/app_routes_map.dart';
import 'package:infinite_scrolling/screens/home_screen.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scrolling',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: appRoutesMap,
      home: const HomeScreen(),
    );
  }
}

extension Log on Object {
  void log() {
    devtools.log(toString());
  }
}
