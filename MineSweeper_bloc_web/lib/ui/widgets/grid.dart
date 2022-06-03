import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minesweeper_refactored/library/useful_methods.dart';
import 'package:minesweeper_refactored/ui/widgets/square.dart';
import '../../core/info.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';
import 'controls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocBuilder<GridCubit, GridState>(
          builder: (context, state) {
            int gridSize = context.read<GridCubit>().sizesOfGrid;
            if (state is GridInitial) {
              return Container(
                alignment: Alignment.center,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: gridSize,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List<Widget>.generate(
                    gridSize * gridSize,
                    (index) {
                      return BlocProvider(
                        create: (context) {
                          return state.allSquareCubitsData[index ~/ gridSize]
                              [index % gridSize];
                        },
                        child: const Square(),
                      );
                    },
                  ),
                ),
              );
            } else {
              context.read<GridCubit>().setInitial();
              return const CircularProgressIndicator();
            }
          },
        ),
        Expanded(
            child: checkTouchability(context)
                ? SizedBox(
                    width: min(MediaQuery.of(context).size.width, maxWidth),
                    height: MediaQuery.of(context).size.height / 7,
                    child: const Controls())
                : const SizedBox.shrink()),
      ],
    );
  }
}
