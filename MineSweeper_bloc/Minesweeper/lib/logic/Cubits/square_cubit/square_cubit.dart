import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/Material.dart';
import 'package:minesweeper_refactored/logic/Cubits/square_selector_cubit/square_selector_cubit.dart';

part 'square_state.dart';

class SquareCubit extends Cubit<SquareState> {
  SquareCubit({
    required this.row,
    required this.column,
    required this.hasBomb,
    required this.bombsNear,
  }) : super(SquareInitial());

  final int row;
  final int column;
  final bool hasBomb;
  final int bombsNear;
  final SquareSelectorCubit selector = SquareSelectorCubit();

  void setSquareToInitial() {
    emit(SquareInitial());
  }

  void switchFlag() {
    if (state is! SquareIsVisible) {
      if (state is SquareIsFlagged) {
        emit(SquareInitial());
      } else {
        emit(SquareIsFlagged());
      }
    }
  }

  void revealSquare() {
    emit(SquareIsVisible(hasBomb: hasBomb, bombsNear: bombsNear));
  }

  @override
  toString() {
    return "(row: $row,column: $column,hasbomb: $hasBomb,bombsNear: $bombsNear)";
  }
}
