import 'package:crud/bloc/field/field_event.dart';
import 'package:crud/bloc/field/field_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc() : super(FieldState()) {
    on<ReadTextEvent>((event, emit) {
      emit(state.copyWith(text: event.text));
    });
  }
}
