class SearchState {
  final String text;
  SearchState({this.text = ""});

  SearchState copyWith({String? text}) {
    return SearchState(text: text ?? this.text);
  }
}
