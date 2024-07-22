abstract class SearchEvent {}

class SearchTextEvent extends SearchEvent {
  final String text;
  SearchTextEvent({required this.text});
}
