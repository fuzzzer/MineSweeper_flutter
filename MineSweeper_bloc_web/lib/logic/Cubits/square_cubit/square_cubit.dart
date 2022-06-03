import 'package:bloc/bloc.dart';
import 'package:flutter/Material.dart';
import 'package:minesweeper_refactored/core/keys.dart';
import 'package:minesweeper_refactored/logic/global_logics/reveal_adjacent_squares.dart';
import 'package:minesweeper_refactored/ui/widgets/game_ending_dialog.dart';
import '../../global_logics/reveal_all.dart';

part 'square_state.dart';

class SquareCubit extends Cubit<SquareState> {
  SquareCubit({
    required this.row,
    required this.column,
    required this.hasBomb,
    required this.bombsNear,
  }) : super(SquareInitial());

  int row;
  int column;
  bool hasBomb;
  int bombsNear;

  void selectSquare() {
    emit(SquareIsSelected());
  }

  void setSquareToInitial() {
    emit(SquareInitial());
  }

  void setSquareFlagged() {
    emit(SquareIsFlagged());
  }

  void revealSquare() {
    emit(SquareIsVisible(hasBomb: hasBomb, bombsNear: bombsNear));
  }

  void openSquaresNeighborhood(
      {required List<List<SquareCubit>> allSquareCubitsData}) {
    if (hasBomb) {
      revealSquare();
      revealAll(allSquareCubitsData);
      gameEndingDialog(navigatorKey.currentContext,
          message: "Boom!", textColor: Colors.red);
    } else {
      revealAdjacents(allSquareCubitsData, row, column);
    }
  }

  @override
  toString() {
    return "(row: $row,column: $column,hasbomb: $hasBomb,bombsNear: $bombsNear)";
  }
}
