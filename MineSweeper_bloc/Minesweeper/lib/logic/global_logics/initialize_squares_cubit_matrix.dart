import '../Cubits/square_cubit/square_cubit.dart';
import 'distribution_of_bombs.dart';

List<List<SquareCubit>> initializedCubitsForGrid(final List<int> args) {
  final int bombsCount = args[0];
  final int sizesOfGrid = args[1];
  final List<List<SquareCubit>> result = [];

  final List<List<bool>> bombs =
      distributeBombs(bombsCount, sizesOfGrid, sizesOfGrid);
  final List<List<int>> bombsNear = makeGridOfCounts(bombs);

  for (int i = 0; i < sizesOfGrid; i++) {
    final List<SquareCubit> tempRow = [];
    for (int j = 0; j < sizesOfGrid; j++) {
      tempRow.add(SquareCubit(
          row: i, column: j, hasBomb: bombs[i][j], bombsNear: bombsNear[i][j]));
    }
    result.add(tempRow);
  }

  return result;
}
