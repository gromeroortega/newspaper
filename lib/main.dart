/*Powered by Zharka */
import 'package:flutter/material.dart';
import 'package:newspaper/src/screens/screens.dart';
import 'package:newspaper/src/services/news_service.dart';
import 'package:newspaper/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
        title: 'NewPaper',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        initialRoute: 'home',
        routes: {
          'home': (_) => const TabScreen(),
        },
      ),
    );
  }
}
