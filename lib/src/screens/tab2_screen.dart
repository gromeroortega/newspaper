import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/src/models/category_model.dart';
import 'package:newspaper/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:newspaper/src/services/news_service.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleCategory =
        Provider.of<NewsService>(context).articlebyCategorySelected;
    return Stack(
      children: [
        NewsGeneric(
          headlines: articleCategory,
        ),
        const Positioned(child: _CategoryList()),
      ],
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    // ignore: sized_box_for_whitespace
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _CategoryButtons(categories: categories[index]),
              Container(
                  // color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    categories[index].title,
                    style: const TextStyle(fontFamily: 'Roboto'),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class _CategoryButtons extends StatelessWidget {
  const _CategoryButtons({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final Category categories;

  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsService>(context);

    return GestureDetector(
        child: Container(
      //color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      child: Ink(
        decoration: const ShapeDecoration(shape: CircleBorder()),
        child: IconButton(
          splashColor: Colors.black,
          splashRadius: 40,
          icon: Icon(
            categories.iconCatgory,
            size: 30,
            color: newsServices.selectedCategory == categories.nameCategory
                ? categories.color
                : Colors.white,
          ),
          onPressed: () {
            newsServices.selectedCategory = categories.nameCategory;
          },
        ),
      ),
    ));
  }
}
