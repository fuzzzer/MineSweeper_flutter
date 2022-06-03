import '../Cubits/square_cubit/square_cubit.dart';
import 'distribution_of_bombs.dart';

List<List<SquareCubit>> initializedCubitsForGrid(
    int bombsCount, int sizesOfGrid) {
  List<List<SquareCubit>> result = [];

  List<List<bool>> bombs =
      distributeBombs(bombsCount, sizesOfGrid, sizesOfGrid);
  List<List<int>> bombsNear = makeGridOfCounts(bombs);

  for (int i = 0; i < sizesOfGrid; i++) {
    List<SquareCubit> tempRow = [];
    for (int j = 0; j < sizesOfGrid; j++) {
      tempRow.add(SquareCubit(
          row: i, column: j, hasBomb: bombs[i][j], bombsNear: bombsNear[i][j]));
    }
    result.add(tempRow);
  }

  return result;
}
