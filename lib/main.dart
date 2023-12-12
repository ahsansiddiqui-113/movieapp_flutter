import 'package:flutter/material.dart';
import 'package:movie_app/navBar/watch_screen.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
