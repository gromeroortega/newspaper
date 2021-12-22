import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:newspaper/src/models/models.dart';

String _baseUrl = 'newsapi.org';
String _apiKey = '0efcfe703cb44a2c822f915c24bb5aea';
String _contry = 'mx';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    getTopHeadlines();
  }

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
