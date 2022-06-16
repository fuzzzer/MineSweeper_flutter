import 'package:bloc/bloc.dart';
import 'package:flutter/Material.dart';
import 'package:minesweeper_refactored/core/info.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  TextEditingController timeInputController =
      TextEditingController(text: startingTime.toString());
  TextEditingController numberOfBombsInputController =
      TextEditingController(text: startingBombsCount.toString());
  TextEditingController squareSizeInputController =
      TextEditingController(text: startingSizesOfGrid.toString());
}
