abstract class FieldEvent {}

class ReadTextEvent extends FieldEvent {
  final String text;
  ReadTextEvent({required this.text});
}
