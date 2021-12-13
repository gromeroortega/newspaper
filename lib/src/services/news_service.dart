import 'package:flutter/material.dart';
import 'package:newspaper/src/providers/models/models.dart';
import 'package:http/http.dart';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() {
    print('no se que estoy haciendo...');
  }
}
