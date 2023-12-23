import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/utils.dart';

class NewsCard extends StatelessWidget {
  final NewsModel model;
  const NewsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            model.urlToImage,
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.source,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  model.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    model.author,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: primaryColor),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: grayColor,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    timeUntil(DateTime.parse(model.publishedAt)),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: grayColor),
                  ),
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
