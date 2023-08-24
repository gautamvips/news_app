class NewsModel {
  //only task is to get news data from the JSON
  late Source source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  NewsModel(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  NewsModel.extractFromJSON(Map<String, dynamic> map) {
    source = Source.extractSourceFromJSON(map['source']);
    author = map['author'] ??
        "not avl"; // if value is null then default value is assigned ("not avl")
    title = map['title'] ?? "not avl";
    description = map['description'] ?? "not avl";
    url = map['url'] ?? "not avl";
    urlToImage = map['urlToImage'] ?? "not avl";
    publishedAt = map['publishedAt'] ?? "not avl";
    content = map['content'] ?? "not avl";
  }
}

class Source {
  late String id;
  late String name;
  Source({required this.id, required this.name});
  Source.extractSourceFromJSON(Map<String, dynamic> map) {
    id = map['id'] ?? "not avl";
    name = map['name'] ?? "not avl";
  }
}
