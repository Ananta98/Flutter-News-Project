class NewsModel {
  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;

  NewsModel(
      {required this.source,
      required this.title,
      required this.author,
      required this.description,
      required this.urlToImage,
      required this.url,
      required this.content,
      required this.publishedAt});

  factory NewsModel.json(Map<String, dynamic> json) {
    return NewsModel(
        source: json["source"]["name"] ?? "",
        title: json["title"] ?? "",
        author: json["author"] ?? "",
        description: json["description"] ?? "",
        urlToImage: json["urlToImage"] ?? "",
        url: json["url"] ?? "",
        content: json["content"] ?? "",
        publishedAt: json["publishedAt"]
      );
  }
}
