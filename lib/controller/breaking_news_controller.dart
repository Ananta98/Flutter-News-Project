import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/service/news_service.dart';
import 'package:get/get.dart';

class BreakingNewsController extends GetxController {
  var breakingNews = <NewsModel>[].obs;
  var isLoading = true.obs;
  NewsService service = NewsService();

  @override
  void onInit() {
    fetchAllBreakingNews();
    super.onInit();
  }

  fetchAllBreakingNews() async {
    try {
      isLoading.value = true;
      var results = await service.getBreakingNews();
      results.fold(
          (errorMessage) => Get.snackbar(
                "Error",
                errorMessage,
                icon: Icon(Icons.error, color: Colors.amber[600]),
                snackPosition: SnackPosition.BOTTOM,
              ),
          (responses) => breakingNews.addAll(responses));
    } finally {
      isLoading.value = false;
    }
  }
}
