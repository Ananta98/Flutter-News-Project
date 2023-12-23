import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/breaking_news_controller.dart';
import 'package:flutter_news_app/screen/article.dart';
import 'package:flutter_news_app/utils.dart';
import 'package:get/get.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BreakingNewsController());
    return SizedBox(
      height: 200,
      child: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
              itemCount: controller.breakingNews.length,
              pageSnapping: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleScreen(
                                        articleModel: controller.breakingNews[index],
                                      )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            controller.breakingNews[index].urlToImage,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                            bottom: 30,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  controller.breakingNews[index].title,
                                  maxLines: 4,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            controller.breakingNews[index].source,
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text(
                            timeUntil(DateTime.parse(
                                controller.breakingNews[index].publishedAt)),
                            style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ArticleScreen(
                                            articleModel:
                                                controller.breakingNews[index])));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
