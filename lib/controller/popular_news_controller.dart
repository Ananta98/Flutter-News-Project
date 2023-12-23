import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/service/news_service.dart';
import 'package:get/get.dart';

class PopularNewsController extends GetxController {
  var popularNewsArticles = <NewsModel>[].obs;
  var isLoading = true.obs;
  NewsService service = NewsService();

  @override
  void onInit() {
    fetchPopularNews();
    super.onInit();
  }

  refreshPopularNews() {
    popularNewsArticles.clear();
    fetchPopularNews();
  }

  fetchPopularNews() async {
    try {
      isLoading.value = true;
      var results = await service.getPopularNews();
      results.fold(
          (errorMessage) => Get.snackbar(
                "Error",
                errorMessage,
                icon: Icon(Icons.error, color: Colors.amber[600]),
                snackPosition: SnackPosition.BOTTOM,
              ),
          (responses) => popularNewsArticles.addAll(responses));
    } finally {
      isLoading.value = false;
    }
  }
}