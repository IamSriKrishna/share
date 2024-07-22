import 'package:crud/bloc/search/search_event.dart';
import 'package:crud/bloc/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<SearchTextEvent>((event, emit) {
      emit(state.copyWith(text: event.text));
    });
  }
}
