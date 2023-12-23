import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/news_category_controller.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/screen/article.dart';
import 'package:flutter_news_app/widget/news_card.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// ignore: must_be_immutable
class CategoryNews extends StatefulWidget {
  String category;

  CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(NewsCategoryController(category: widget.category), tag: widget.category);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${controller.category} News",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    hintText: "search news here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none)),
                onSubmitted: (value) {
                  setState(() {
                    controller.updateSearchTerm(value);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "All ${controller.category} News",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
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
                                                  articleModel:
                                                      item,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: NewsCard(
                                      model: item,
                                    ),
                                  ),
                                )),
                      ))
          ],
        ),
      ),
    );
  }
}
