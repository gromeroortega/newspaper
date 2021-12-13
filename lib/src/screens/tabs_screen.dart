import 'package:flutter/material.dart';
import 'package:newspaper/src/services/services.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigatorModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigetor(),
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
    final newsService = Provider.of<NewsService>(context);
    return BottomNavigationBar(
      currentIndex: navigator._currentPage,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Page'),
        BottomNavigationBarItem(
            icon: Icon(Icons.baby_changing_station), label: 'perro')
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
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        )
      ],
    );
  }
}

class _NavigatorModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;

    _pageController.animateToPage(_currentPage,
        curve: Curves.decelerate, duration: const Duration(milliseconds: 250));
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
