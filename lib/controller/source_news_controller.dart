import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/service/news_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SourceNewsController extends GetxController {
  var sourceNewsArticles = <NewsModel>[].obs;
  var isLoading = true.obs;
  NewsService service = NewsService();
  String sourceId = '';
  var page = 1.obs;
  var hasMore = true.obs;
  static const pageSize = 10;

  SourceNewsController({required this.sourceId});

  final PagingController<int, NewsModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchSourceNews(sourceId, pageKey);
    });
    super.onInit();
  }

  fetchSourceNews(String sourceId, int page) async {
    var results = await service.getSourceNews(sourceId, page);
    results.fold(
        (errorMessage) => Get.snackbar(
              "Error",
              errorMessage,
              icon: Icon(Icons.error, color: Colors.amber[600]),
              snackPosition: SnackPosition.BOTTOM,
            ), (responses) {
      final isLastPage = responses.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(responses);
      } else {
        final nextPageKey = page + responses.length;
        pagingController.appendPage(responses, nextPageKey);
      }
    });
  }
}
