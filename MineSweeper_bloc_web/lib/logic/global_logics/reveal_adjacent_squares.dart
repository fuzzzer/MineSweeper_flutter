import 'dart:math';
import 'package:minesweeper_refactored/logic/Cubits/square_cubit/square_cubit.dart';
import '../../core/info.dart';

int squaresOpened = 0;

void revealAdjacents(
  List<List<SquareCubit>> allSquareCubitsData,
  int row,
  int column,
) async {
  // this is recursive method to reveal all cell that are not adjacent to the bomb
  await Future.delayed(const Duration(microseconds: 200));
  if ((allSquareCubitsData[row][column].bombsNear != 0) &&
      (allSquareCubitsData[row][column].state is! SquareIsVisible)) {
    revealCell(allSquareCubitsData, row, column);
  }

  if ((allSquareCubitsData[row][column].bombsNear == 0) &&
      (allSquareCubitsData[row][column].state is! SquareIsVisible)) {
    revealCell(allSquareCubitsData, row, column);

    //this will go through adjacent cells and sets them to visible
    int startingRow = max(0, row - neigborhoodSize - 1);
    int endingRow =
        min(allSquareCubitsData.length - 1, row + neigborhoodSize + 1);
    int startingColumn = max(0, column - neigborhoodSize - 1);
    int endingColumn =
        min(allSquareCubitsData[0].length - 1, column + neigborhoodSize + 1);

    for (int i = startingRow; i <= endingRow; i++) {
      for (int j = startingColumn; j <= endingColumn; j++) {
        revealAdjacents(allSquareCubitsData, i, j);
      }
    }
  }
}

void revealCell(
  List<List<SquareCubit>> allSquareCubitsData,
  int row,
  int column,
) {
  allSquareCubitsData[row][column].revealSquare();
  squaresOpened++;
  // if (sizesOfGrid * sizesOfGrid - squaresOpened == bombsCount) {
  //   dialog(context, message: 'You Win!', textColor: Colors.green, reveal: true);
  // }
}
