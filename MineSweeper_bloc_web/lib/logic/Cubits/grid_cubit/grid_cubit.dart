import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/Material.dart';
import 'package:minesweeper_refactored/core/info.dart';
import '../../global_logics/initialize_squares_cubit_matrix.dart';
import '../square_cubit/square_cubit.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit({required this.gridData}) : super(GridInitial(gridData));

  List<List<SquareCubit>> gridData;
  int bombsCount = startingBombsCount;
  int sizesOfGrid = startingSizesOfGrid;

  void setInitial() {
    gridData.clear();
    gridData = initializedCubitsForGrid(bombsCount, sizesOfGrid);
    emit(GridInitial(gridData));
  }

  void updateGrid() {
    emit(GridUpdated());
  }

  void setSettings(int numberOfBombs, int size) {
    bool changes = false;

    if (size != sizesOfGrid && size > 4 && size < 26) {
      if ((numberOfBombs > 0 && numberOfBombs < size * size) ||
          (bombsCount < size * size)) {
        sizesOfGrid = size;
        changes = true;
      }
    } // bombs should not be more than size or it will crash

    if (numberOfBombs != bombsCount &&
        numberOfBombs > 0 &&
        numberOfBombs < sizesOfGrid * sizesOfGrid) {
      bombsCount = numberOfBombs;
      changes = true;
    }

    if (changes) {
      updateGrid();
    }
  }

  double changeOfX = 0;
  double changeOfY = 0;
  int currentColumn = 0;
  int currentRow = 0;
  int lastColumn = 0;
  int lastRow = 0;

  void onPanUpdate(
      DragUpdateDetails details, double screenWidth, double screenHeight) {
    var deltaX = details.delta.dx;
    var deltaY = details.delta.dy;

    int columnDelta = handleXCoordinatesChange(deltaX, screenWidth);
    int rowDelta = handleYCoordinatesChange(deltaY, screenHeight);

    currentColumn = (currentColumn + columnDelta) % sizesOfGrid;
    currentRow = (currentRow + rowDelta) % sizesOfGrid;
    print("columndelta: $columnDelta");
    print("row: $currentRow");

    if (columnDelta != 0) {
      for (int i = 0; i < sizesOfGrid; i++) {
        int columnToCheck = (currentColumn + columnDelta * i) % sizesOfGrid;
        if (gridData[currentRow][columnToCheck].state is! SquareIsVisible) {
          currentColumn = columnToCheck;
          setSquareSelected();

          break;
        }
      }
    }

    if (rowDelta != 0) {
      for (int i = 0; i < sizesOfGrid; i++) {
        int rowToCheck = (currentRow + rowDelta * i) % sizesOfGrid;
        if (gridData[rowToCheck][currentColumn].state is! SquareIsVisible) {
          currentRow = rowToCheck;
          setSquareSelected();

          break;
        }
      }
    }
  }

  int handleXCoordinatesChange(double delta, double totalSize) {
    changeOfX = changeOfX + delta;
    int sign = 1;
    if (changeOfX < 0) sign = -1;
    if (changeOfX * sign > totalSize / sizesOfGrid) {
      changeOfX = 0;
      return sign;
    }
    return 0;
  }

  int handleYCoordinatesChange(double delta, double totalSize) {
    changeOfY = changeOfY + delta;
    int sign = 1;
    if (changeOfY < 0) sign = -1;
    if (changeOfY * sign > totalSize / sizesOfGrid) {
      changeOfY = 0;
      return sign;
    }
    return 0;
  }

  void setSquareSelected() {
    if (gridData[lastRow][lastColumn].state is! SquareInitial) {
      gridData[lastRow][lastColumn].setSquareToInitial();
    }

    gridData[currentRow][currentColumn].selectSquare();
    lastRow = currentRow;
    lastColumn = currentColumn;
  }
}
