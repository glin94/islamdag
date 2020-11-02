import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:islamdag/models/article.dart';
import 'package:islamdag/resources/api_provider.dart';
import 'package:rxdart/rxdart.dart';
part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc(this.slug) : super(const ArticleState());
  final String slug;
  int page = 0;
  @override
  Stream<Transition<ArticleEvent, ArticleState>> transformEvents(
    Stream<ArticleEvent> events,
    TransitionFunction<ArticleEvent, ArticleState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is Fetch) {
      if (state.hasReachedMax) yield state;
      try {
        if (state.status == ArticleStatus.initial) {
          final articles = await fetchArticles(slug, page);
          yield state.copyWith(
            status: ArticleStatus.success,
            articles: articles,
            hasReachedMax: false,
          );
        }
        page++;
        final articles = await fetchArticles(slug, page);
        yield articles.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: ArticleStatus.success,
                articles: List.of(state.articles)..addAll(articles),
                hasReachedMax: false,
              );
      } on Exception {
        yield state.copyWith(status: ArticleStatus.failure);
      }
    }
  }
}
