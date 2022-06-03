import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:minesweeper_refactored/core/info.dart';
import '../../../core/keys.dart';
import '../../../ui/widgets/game_ending_dialog.dart';
import '../../global_logics/initialize_squares_cubit_matrix.dart';
import '../../global_logics/reveal_adjacent_squares.dart';
import '../../global_logics/reveal_all.dart';
import '../square_cubit/square_cubit.dart';
import '../square_selector_cubit/square_selector_cubit.dart';

part 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit({required this.gridData}) : super(GridInitial(gridData)) {
    setStartingSelectedCell();
  }

  List<List<SquareCubit>> gridData;
  int bombsCount = startingBombsCount;
  int sizesOfGrid = startingSizesOfGrid;

  late int currentColumn;
  late int currentRow;
  late int lastColumn;
  late int lastRow;
  double changeOfX = 0;
  double changeOfY = 0;

  void setStartingSelectedCell() {
    currentColumn = gridData.length ~/ 2;
    currentRow = gridData.length ~/ 2;
    lastColumn = currentColumn;
    lastRow = currentRow;
    gridData[currentRow][currentRow].selector.select();
  }

  void setInitial() async {
    emit(GridInitial(gridData));
  }

  void setUpdating() async {
    emit(GridUpdating());
  }

  void updateGrid() async {
    gridData =
        await compute(initializedCubitsForGrid, ([bombsCount, sizesOfGrid]));
    setStartingSelectedCell();
    // emit(GridUpdating());
    emit(GridInitial(gridData));
  }

  void setSettings(final int numberOfBombs, final int size) {
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

    // if (changes) {
    //   updateGrid();
    // }
    setUpdating();
  }

  void onPanUpdate(final DragUpdateDetails details, final double gridWidth,
      final double gridHeight) {
    final double deltaX = details.delta.dx;
    final double deltaY = details.delta.dy;

    final int columnDelta = handleXCoordinatesChange(deltaX, gridWidth);
    final int rowDelta = handleYCoordinatesChange(deltaY, gridHeight);

    currentColumn = (currentColumn + columnDelta) % sizesOfGrid;
    currentRow = (currentRow + rowDelta) % sizesOfGrid;

    if (columnDelta != 0) {
      setSquareSelected();
    }

    if (rowDelta != 0) {
      setSquareSelected();
    }
  }

  int handleXCoordinatesChange(final double delta, final double totalSize) {
    changeOfX = changeOfX + delta;
    int sign = 1;
    if (changeOfX < 0) sign = -1;
    if (changeOfX * sign > totalSize / sizesOfGrid) {
      changeOfX = 0;
      return sign;
    }
    return 0;
  }

  int handleYCoordinatesChange(final double delta, final double totalSize) {
    changeOfY = changeOfY + delta;
    int sign = 1;
    if (changeOfY < 0) sign = -1;
    if (changeOfY * sign > totalSize / sizesOfGrid) {
      changeOfY = 0;
      return sign;
    }
    return 0;
  }

  void handleOneTap(final TapDownDetails details, final Offset offset,
      final double gridScreenSize) {
    double currentX = details.globalPosition.dx;
    double currentY = details.globalPosition.dy;

    if (currentX > offset.dx &&
        currentX < offset.dx + gridScreenSize &&
        currentY > offset.dy &&
        currentY < offset.dy + gridScreenSize) {
      currentColumn =
          ((currentX - offset.dx) / gridScreenSize * sizesOfGrid).round();
      currentRow =
          ((currentY - offset.dy) / gridScreenSize * sizesOfGrid).round();
    }
    setSquareSelected();
  }

  void setSquareSelected() {
    if (gridData[lastRow][lastColumn].selector.state is SquareIsSelected) {
      gridData[lastRow][lastColumn].selector.unselect();
    }

    gridData[currentRow][currentColumn].selector.select();
    lastRow = currentRow;
    lastColumn = currentColumn;
  }

  void openSquaresNeighborhood() {
    if (gridData[currentRow][currentColumn].state is SquareInitial) {
      if (gridData[currentRow][currentColumn].hasBomb) {
        gridData[currentRow][currentColumn].revealSquare();
        revealAll(gridData);
        gameEndingDialog(navigatorKey.currentContext,
            message: "Boom!", textColor: Colors.red);
      } else {
        revealAdjacents(gridData, currentRow, currentColumn);
      }
    }
  }

  void switchFlag() {
    gridData[currentRow][currentColumn].switchFlag();
  }
}
