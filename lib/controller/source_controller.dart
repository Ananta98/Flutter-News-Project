import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/source_model.dart';
import 'package:flutter_news_app/service/news_service.dart';
import 'package:get/get.dart';

class SourceController extends GetxController {
  var isLoading = true.obs;
  var sources = <SourceModel>[].obs;
  NewsService service = NewsService();

  @override
  void onInit() {
    fetchSources();
    super.onInit();
  }

  refreshSources() {
    sources.clear();
    fetchSources();
  }

  fetchSources() async {
    try {
      isLoading.value = true;
      var results = await service.getSources();
      results.fold(
          (errorMessage) => Get.snackbar(
                "Error",
                errorMessage,
                icon: Icon(Icons.error, color: Colors.amber[600]),
                snackPosition: SnackPosition.BOTTOM,
              ),
          (responses) => sources.addAll(responses));
    } finally {
      isLoading.value = false;
    }
    update();
  }
}
