import 'package:flutter/material.dart';
import 'package:flutter_news_app/controller/popular_news_controller.dart';
import 'package:flutter_news_app/widget/news_card.dart';
import 'package:get/get.dart';

class PopularNewsList extends StatelessWidget {
  const PopularNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PopularNewsController());
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children:
                  List.generate(controller.popularNewsArticles.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NewsCard(
                    model: controller.popularNewsArticles[index],
                  ),
                );
              }),
            ),
    );
  }
}
