import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'square_selector_state.dart';

class SquareSelectorCubit extends Cubit<SquareSelectorState> {
  SquareSelectorCubit() : super(SquareIsNotSelected());

  void select() {
    emit(SquareIsSelected());
  }

  void unselect() {
    emit(SquareIsNotSelected());
  }
}
