import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:newspaper/src/screens/screens.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(color: Color.fromRGBO(255, 87, 51, 1), fontFamily: 'Roboto');
    return ChangeNotifierProvider(
      create: (_) => _NavigatorModel(),
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
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune,
                  color: Color.fromRGBO(255, 87, 51, 1),
                ))
          ],
        ),
        body: const _Pages(),
        extendBody: true,
        extendBodyBehindAppBar: true,
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
    final navigator = Provider.of<_NavigatorModel>(context);
    //final newsService = Provider.of<NewsService>(context);
    return BottomNavigationBar(
      unselectedItemColor: Colors.white70,
      selectedItemColor: const Color.fromRGBO(255, 87, 51, 1),
      currentIndex: navigator._currentPage,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.view_headline), label: 'Top'),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports_baseball), label: 'Deportes'),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports), label: 'Tecnología'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Espectaculo')
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
    final navigator = Provider.of<_NavigatorModel>(context);
    return PageView(
      controller: navigator.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Tab1Screen(),
        Container(
          color: Colors.blue,
        )
      ],
    );
  }
}

class _NavigatorModel with ChangeNotifier {
  int _currentPage = 0;
  String currenTitle = 'Top';
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(_currentPage,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 250));
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
