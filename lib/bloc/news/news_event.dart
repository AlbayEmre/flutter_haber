import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewsEvent extends NewsEvent {
  final String category;
  const FetchNewsEvent({this.category = 'general'});

  @override
  List<Object?> get props => [category];
}

class SearchNewsEvent extends NewsEvent {
  final String query;
  const SearchNewsEvent(this.query);

  @override
  List<Object?> get props => [query];
}
