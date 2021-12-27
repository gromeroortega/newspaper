import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:newspaper/src/models/models.dart';

String _baseUrl = 'newsapi.org';
String _apiKey = '0efcfe703cb44a2c822f915c24bb5aea';
String _contry = 'mx';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(Icons.business, 'business', const Color.fromRGBO(255, 178, 122, 1),
        'Negocios'),
    Category(Icons.tv, 'entertainment', const Color.fromRGBO(255, 232, 118, 1),
        'TV'),
    Category(Icons.dialpad, 'general', const Color.fromRGBO(125, 250, 146, 1),
        'General'),
    Category(Icons.psychology, 'healths', const Color.fromRGBO(7, 180, 194, 1),
        'Salud'),
    Category(Icons.sports_baseball, 'sports',
        const Color.fromRGBO(207, 150, 255, 1), 'Deportes'),
    Category(Icons.sports_esports, 'technology',
        const Color.fromRGBO(255, 123, 178, 1), 'Tecnología'),
    Category(Icons.science, 'cience', const Color.fromRGBO(183, 1, 83, 1),
        'Ciencia'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.nameCategory] = [];
    }
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    getNewsByCategory(_selectedCategory);
    notifyListeners();
  }

  List<Article> get articlebyCategorySelected =>
      categoryArticles[selectedCategory]!;

/*-------------------------------------------GETBYCATEGORY-------------------------------------------------*/
  Future<List<Article>> getNewsByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category]!;
    }
    print(category);
    final Map<String, dynamic> data = {
      'apiKey': _apiKey,
      'country': _contry,
      'category': category
    };
    final url = Uri.http(_baseUrl, 'v2/top-headlines', data);

    final response = await http.get(url);
    final decode = json.decode(response.body);
    final temp = NewsResponse.fromJson(decode);
    int i = 0;
    for (var item in temp.articles!) {
      String urlImage = temp.articles![i].urlToImage;
      bool validImage = Uri.parse(urlImage).isAbsolute;

      if (validImage) {
        categoryArticles[category]!.add(item);
      } else {
        final prueba = item.toJson();
        prueba.update('urlToImage', (value) => '');
        final itemCorrect = Article(
            source: Source.fromJson(prueba['source']),
            title: prueba['title'],
            url: prueba['url'],
            urlToImage: '');
        categoryArticles[category]!.add(itemCorrect);
      }
      i++;
    }
    final List<Article> results = categoryArticles[category]!;
    notifyListeners();
    return results;
  }

/*----------------------------------------------HEADLINES--------------------------------------- */
  Future<List<Article>> getTopHeadlines() async {
    final Map<String, dynamic> data = {
      'apiKey': _apiKey,
      'country': _contry,
    };
    final url = Uri.http(_baseUrl, 'v2/top-headlines', data);

    final response = await http.get(url);
    final decode = json.decode(response.body);
    final temp = NewsResponse.fromJson(decode);
    int i = 0;
    for (var item in temp.articles!) {
      String urlImage = temp.articles![i].urlToImage;
      bool validImage = Uri.parse(urlImage).isAbsolute;

      if (validImage) {
        headlines.add(item);
      } else {
        final prueba = item.toJson();
        prueba.update('urlToImage', (value) => '');
        final itemCorrect = Article(
            source: Source.fromJson(prueba['source']),
            title: prueba['title'],
            url: prueba['url'],
            urlToImage: '');
        headlines.add(itemCorrect);
      }
      i++;
    }

    notifyListeners();
    return headlines;
  }
}
