import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/source_news_controller.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/model/source_model.dart';
import 'package:flutter_news_app/screen/article.dart';
import 'package:flutter_news_app/widget/news_card.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// ignore: must_be_immutable
class SourceDetails extends StatelessWidget {
  SourceModel model;

  SourceDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(SourceNewsController(sourceId: model.id), tag: model.id);
    return Scaffold(
        appBar: AppBar(
          title: Text(model.name),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                height: MediaQuery.of(context).size.height * 0.25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/logos/${controller.sourceId}.png")),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            model.description,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: PagedListView<int, NewsModel>(
                      pagingController: controller.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<NewsModel>(
                          itemBuilder: (context, item, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ArticleScreen(
                                                articleModel: item,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  child: NewsCard(
                                    model: item,
                                  ),
                                ),
                              ))))
            ],
          ),
        ));
  }
}
