import 'package:flutter/material.dart';
import 'package:newspaper/src/models/models.dart';

class NewsGeneric extends StatelessWidget {
  final List<Article> headlines;

  const NewsGeneric({
    Key? key,
    required this.headlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: headlines.length,
      itemBuilder: (_, int index) {
        Color color = const Color.fromRGBO(183, 1, 83, 1);
        final Article article = headlines[index];
        return newGeneric(article, color);
      },
    );
  }

  Padding newGeneric(Article article, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          imageNew(article),
          const SizedBox(),
          headlineNew(article, color),
          const Divider(
            thickness: 1,
            height: 20,
            color: Colors.black26,
          )
        ],
      ),
    );
  }

  ClipRRect imageNew(Article article) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: article.urlToImage == ''
            ? const Image(image: AssetImage('assets/noimage.jpg'))
            : FadeInImage(
                placeholder: const AssetImage('assets/giphy.gif'),
                image: NetworkImage(article.urlToImage)));
  }

  Padding headlineNew(Article article, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text(
            article.title,
            style: const TextStyle(
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(
            height: 10,
          ),
          footerNew(article, color)
        ],
      ),
    );
  }

  Row footerNew(Article article, Color color) {
    String source = article.source.name ?? 'Anónimo';
    return Row(
      children: [
        Text(
          source,
          style: TextStyle(color: color, fontFamily: 'Roboto'),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Icon(
            Icons.favorite_border,
            size: 18,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Icon(
            Icons.share,
            size: 18,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Icon(
            Icons.tune,
            size: 18,
            color: color,
          ),
        ),
      ],
    );
  }
}
