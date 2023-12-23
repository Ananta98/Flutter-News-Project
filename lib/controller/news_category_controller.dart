import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:flutter_news_app/service/news_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NewsCategoryController extends GetxController {
  var news = <NewsModel>[].obs;
  var isLoading = true.obs;
  var searchFilter = ''.obs;
  var page = 1.obs;
  var hasMore = true.obs;
  var category = 'General';

  final NewsService service = NewsService();

  static const pageSize = 10;

  final PagingController<int, NewsModel> pagingController =
      PagingController(firstPageKey: 1);

  NewsCategoryController({required this.category});

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchCategoryNews(pageKey, category, searchFilter.value);
    });
    super.onInit();
  }

  fetchCategoryNews(int page, String category, String search) async {
    try {
      isLoading.value = true;
      var result =
          await service.fetchCategoryNews(page: page, category: category, q: search);
      result.fold(
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
    } finally {
      isLoading.value = false;
    }
    update();
  }

  updateSearchTerm(String value) async {
    searchFilter.value = value;
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
