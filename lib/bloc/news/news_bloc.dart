import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_haber/bloc/news/news_event.dart';
import 'package:flutter_haber/bloc/news/news_state.dart';
import 'package:flutter_haber/data/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNewsEvent>(_onFetchNews);
    on<SearchNewsEvent>(_onSearchNews);
  }

  Future<void> _onFetchNews(FetchNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final articles = await newsRepository.getTopHeadlines(category: event.category);
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError('Haberler yüklenirken bir hata oluştu.'));
    }
  }

  Future<void> _onSearchNews(SearchNewsEvent event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final articles = await newsRepository.searchNews(event.query);
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError('Arama yapılırken bir hata oluştu.'));
    }
  }
}
