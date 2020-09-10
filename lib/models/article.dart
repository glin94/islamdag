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
  String url;

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

  Article(
      {this.id,
      this.voprosi,
      this.isReading,
      this.isFavored,
      this.title,
      this.url,
      this.author,
      this.content,
      this.date,
      this.images,
      this.totalCount});

  factory Article.fromJson(Map<dynamic, dynamic> jsonArticle) {
    return Article(
        voprosi: jsonArticle["field_voprosi"],
        isFavored: false,
        isReading: false,
        title: jsonArticle['title'],
        id: jsonArticle['nid'],
        images: jsonArticle["field_image"],
        date: jsonArticle["created"],
        content: jsonArticle['body'],
        author: jsonArticle["field_avtor"],
        url: jsonArticle["path"] ??
            jsonArticle["field_book"] ??
            jsonArticle["field_videoteka_new"],
        totalCount: jsonArticle["totalcount"]);
  }

  @override
  String toString() => 'Article { id: $id }';

  @override
  List<Object> get props => [id, title, author];
}
