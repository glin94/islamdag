part of 'article_bloc.dart';

enum ArticleStatus { initial, success, failure }

class ArticleState extends Equatable {
  final ArticleStatus status;
  final List<Article> articles;
  final bool hasReachedMax;

  const ArticleState({
    this.status = ArticleStatus.initial,
    this.articles = const <Article>[],
    this.hasReachedMax = false,
  });

  ArticleState copyWith({
    ArticleStatus status,
    List<Article> articles,
    bool hasReachedMax,
  }) {
    return ArticleState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, articles, hasReachedMax];
}
