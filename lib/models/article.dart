import 'package:equatable/equatable.dart';

class Article extends Equatable {
  String id;

  String date;

  String title;

  String content;

  String path;

  String totalCount;

  bool isFavored;

  bool isReading;

  dynamic author;

  List<dynamic> images;

  String voprosi;

  String url;

  String categoryName;

  Article({
    this.id,
    this.voprosi,
    this.isReading,
    this.isFavored,
    this.title,
    this.path,
    this.author,
    this.content,
    this.date,
    this.images,
    this.url,
    this.categoryName,
    this.totalCount,
  });

  factory Article.fromJson(Map<dynamic, dynamic> jsonArticle) => Article(
        categoryName: parseCategoryName(jsonArticle["path"]),
        voprosi: jsonArticle["field_voprosi"] ?? "",
        isFavored: false,
        isReading: false,
        title: jsonArticle['title'] ?? "",
        id: jsonArticle['nid'],
        images: jsonArticle["field_image"] ?? [],
        date: jsonArticle["created"] ?? "",
        content: jsonArticle['body'] ?? "",
        author: jsonArticle["field_avtor"],
        path: jsonArticle["path"] ?? "",
        url: jsonArticle["field_book"] ??
            jsonArticle["field_videoteka_new"] ??
            "",
        totalCount: jsonArticle["totalcount"] ?? "",
      );

  static String parseCategoryName(String path) {
    switch (path.split("/")[1]) {
      case "verouchenie":
        return "Вероучение";
        break;
      case "analitika":
        return "Аналитика";
        break;
      case "istoriya":
        return "История";
        break;
      case "lichnosti":
        return "Личности";
        break;
      case "musulmanka":
        return "Мусульманка";
        break;
      case "vse-ob-islame":
        return "Все об Исламе";
        break;
      case "v-islame":
        return "В исламе";
        break;
      case "intervy":
        return "Интервью";
        break;
      case "news":
        return "Новости";
        break;
      default:
        return "Разное";
    }
  }

  @override
  List<Object> get props => [id, title, author];
}
