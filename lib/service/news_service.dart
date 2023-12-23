import 'package:dio/dio.dart';
import 'package:flutter_news_app/model/news_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_news_app/model/source_model.dart';

class NewsService {
  final Dio dio = Dio();
  final apiKey = "a168ec3fb5eb4aaa9b39d99a8d67eb80";
  final String baseURL = 'https://newsapi.org/v2';

  Future<Either<String, List<NewsModel>>> getBreakingNews() async {
    try {
      var queryParameters = {
        "apiKey": apiKey,
        "language": "en",
        "country": "us",
        "page": 1,
        "pageSize": 10,
      };
      Response response = await dio.get('$baseURL/top-headlines',
          options: Options(headers: {"Accept": "application/json"}),
          queryParameters: queryParameters);
      List<dynamic> result = response.data["articles"];
      if (response.statusCode == 200 || response.statusCode == 201) {
        var breakingNews = result.map((e) => NewsModel.json(e)).toList();
        return Right(
            breakingNews.where((element) => element.urlToImage != "").toList());
      }
      return const Left('Error get news sources');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on search news');
    }
  }

  Future<Either<String, List<NewsModel>>> getPopularNews() async {
    try {
      var queryParameters = {
        "apiKey": apiKey,
        "country": "us",
        "page": 2,
        "pageSize": 10,
        "category": "politics"
      };
      Response response = await dio.get('$baseURL/top-headlines',
          options: Options(headers: {"Accept": "application/json"}),
          queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> result = response.data["articles"];
        var breakingNews = result.map((e) => NewsModel.json(e)).toList();
        return Right(
            breakingNews.where((element) => element.urlToImage != "").toList());
      }
      return const Left('Error get news sources');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on search news');
    }
  }

  Future<Either<String, List<NewsModel>>> search(String value) async {
    try {
      var queryParameters = {
        "apiKey": apiKey,
        "language": "en",
        "country": "us",
        "searchIn": "title",
        "q": value,
      };
      Response response = await dio.get('$baseURL/everything',
          options: Options(headers: {"Accept": "application/json"}),
          queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> result = response.data;
        return Right(result.map((e) => NewsModel.json(e)).toList());
      }
      return const Left('Error get news sources');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on search news');
    }
  }

  Future<Either<String, List<SourceModel>>> getSources() async {
    try {
      var params = {"apiKey": apiKey, "language": "en", "country": "us"};
      Response response =
          await dio.get('$baseURL/sources', queryParameters: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> result = response.data["sources"];
        return Right(result.map((e) => SourceModel.fromJson(e)).toList());
      }
      return const Left('Error get news sources');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get news sources');
    }
  }

  Future<Either<String, List<NewsModel>>> getSourceNews(
      String sourceId, int page) async {
    try {
      var params = {
        "apiKey": apiKey,
        "sources": sourceId,
        "page": page,
        "pageSize": 10
      };
      Response response =
          await dio.get('$baseURL/top-headlines', queryParameters: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> result = response.data["articles"];
        return Right(result.map((e) => NewsModel.json(e)).toList());
      }
      return const Left('Error get source news articles');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on get sources news articles');
    }
  }

  Future<Either<String, List<NewsModel>>> fetchCategoryNews(
      {int page = 1, String category = "", String q = ""}) async {
    try {
      var queryParameters = {
        "apiKey": apiKey,
        "country": "us",
        "category": category.toLowerCase(),
        "page": page,
        "pageSize": 10,
      };
      String url = "$baseURL/top-headlines";
      if (q.isNotEmpty) {
        queryParameters = {
          "apiKey": apiKey,
          "page": page,
          "pageSize": 10,
          "q": q,
          "searchIn": "title"
        };
        url = "$baseURL/everything";
      }
      Response response = await dio.get(url,
          options: Options(headers: {"Accept": "application/json"}),
          queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> result = response.data["articles"];
        var breakingNews = result.map((e) => NewsModel.json(e)).toList();
        return Right(
            breakingNews.where((element) => element.urlToImage != "").toList());
      }
      return const Left('Error get news sources');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another error on search news');
    }
  }
}
