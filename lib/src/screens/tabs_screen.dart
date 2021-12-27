import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newspaper/src/screens/screens.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(color: Color.fromRGBO(183, 1, 83, 1), fontFamily: 'Roboto');
    return ChangeNotifierProvider(
      create: (_) => NavigatorModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black.withOpacity(0.7),
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Top',
              style: textStyle,
            ),
          ),
          title: const Text(
            'News',
            style: textStyle,
          ),
        ),
        body: const _Pages(),
        extendBody: true,
        primary: false,
        bottomNavigationBar: const _Navigetor(),
      ),
    );
  }
}

class _Navigetor extends StatelessWidget {
  const _Navigetor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigatorModel>(context);
    //final newsService = Provider.of<NewsService>(context);
    return BottomNavigationBar(
      unselectedItemColor: Colors.white70,
      selectedItemColor: const Color.fromRGBO(183, 1, 83, 1),
      currentIndex: navigator.currentPage1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Para ti'),
        BottomNavigationBarItem(
            icon: Icon(Icons.new_label_sharp), label: 'All'),
      ],
      onTap: (i) => navigator.currentPage = i,
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigatorModel>(context);
    return PageView(
      controller: navigator.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Screen(), Tab2Screen()],
    );
  }
}

class NavigatorModel with ChangeNotifier {
  int currentPage1 = 0;
  String currenTitle = 'Para ti';
  final PageController _pageController = PageController();

  int get currentPage => currentPage1;

  set currentPage(int value) {
    currentPage1 = value;

    _pageController.animateToPage(currentPage1,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 250));
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
