class FieldState {
  final String text;
  FieldState({this.text = ""});

  FieldState copyWith({String? text}) {
    return FieldState(text: text ?? this.text);
  }
}
