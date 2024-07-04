import 'package:equatable/equatable.dart';

abstract class MainEvents extends Equatable {}

class OnInit extends MainEvents {
  OnInit();

  @override
  List<Object> get props => [];
}

class LoadUsers extends MainEvents {
  LoadUsers({required this.page, required this.letterRange});
  final int page;
  final String letterRange;

  @override
  List<Object> get props => [page, letterRange];
}

class SearchUsers extends MainEvents {
  SearchUsers({required this.query});
  final String query;

  @override
  List<Object> get props => [query];
}
