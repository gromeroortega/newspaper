/*Powered by Zharka */
import 'package:flutter/material.dart';
import 'package:newspaper/src/screens/screens.dart';
import 'package:newspaper/src/theme/dark_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewPaper',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      initialRoute: 'home',
      routes: {
        'home': (_) => TabScreen(),
      },
    );
  }
}
