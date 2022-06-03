import 'dart:math';
import '../../core/info.dart';
import '../../library/useful_methods.dart';

Random rgen = Random();

List<List<bool>> distributeBombs(int bombsCount, int n, int m) {
  List<List<bool>> result = generate2DBoolList(n, m);

  for (int k = 0; k < bombsCount; k++) {
    int totalCells = n * m;
    int bombCoefficient = rgen.nextInt(totalCells);

    int row = (bombCoefficient) ~/ m;
    int column = (bombCoefficient) % m;

    if (!result[row][column]) {
      result[row][column] = true;
    } else {
      k--;
    }
  }
  return result;
}

void addOneToANeigborhood(List<List<int>> counts, int row, int column) {
  int startingRow = max(0, row - neigborhoodSize - 1);
  int endingRow = min(counts.length - 1, row + neigborhoodSize + 1);
  int startingColumn = max(0, column - neigborhoodSize - 1);
  int endingColumn = min(counts[0].length - 1, column + neigborhoodSize + 1);

  for (int i = startingRow; i <= endingRow; i++) {
    for (int j = startingColumn; j <= endingColumn; j++) {
      counts[i][j]++;
    }
  }
}

List<List<int>> makeGridOfCounts(List<List<bool>> bombs) {
  var result = generate2DIntList(bombs.length, bombs[0].length);

  for (int i = 0; i < bombs.length; i++) {
    for (int j = 0; j < bombs[0].length; j++) {
      if (bombs[i][j]) addOneToANeigborhood(result, i, j);
    }
  }

  return result;
}
