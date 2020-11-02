import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Article extends Equatable with HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String date;

  @HiveField(2)
  String title;

  @HiveField(3)
  String content;

  @HiveField(4)
  String path;

  @HiveField(5)
  String totalCount;

  @HiveField(6)
  bool isFavored;

  @HiveField(7)
  bool isReading;

  @HiveField(8)
  dynamic author;

  @HiveField(9)
  List<dynamic> images;

  @HiveField(10)
  String voprosi;

  @HiveField(11)
  String url;

  @HiveField(12)
  String categoryName;

  Article(
      {this.id,
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
      this.totalCount});

  factory Article.fromJson(Map<dynamic, dynamic> jsonArticle) {
    return Article(
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
            totalCount: jsonArticle["totalcount"]) ??
        "";
  }
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
