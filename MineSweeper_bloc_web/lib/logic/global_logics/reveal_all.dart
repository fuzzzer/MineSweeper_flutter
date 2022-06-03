import 'package:minesweeper_refactored/core/global_variables.dart';
import 'package:minesweeper_refactored/logic/Cubits/square_cubit/square_cubit.dart';

void revealAll(
  List<List<SquareCubit>> allSquareCubitsData,
) async {
  computing = true;
  for (int i = 0; i < allSquareCubitsData.length; i++) {
    for (int j = 0; j < allSquareCubitsData[i].length; j++) {
      if (computing &&
          allSquareCubitsData[i][j].state is! SquareIsVisible &&
          allSquareCubitsData[i][j].hasBomb) {
        allSquareCubitsData[i][j].revealSquare();
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }
}
