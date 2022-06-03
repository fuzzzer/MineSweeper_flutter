import 'dart:math';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/logic/Cubits/grid_cubit/grid_cubit.dart';
import '../../logic/Cubits/flag_cubit/flag_cubit.dart';
import '../../logic/Cubits/square_cubit/square_cubit.dart';

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SquareCubit, SquareState>(
      builder: (context, state) {
        if (state is SquareInitial) {
          //--init
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black)),
            child: InkWell(
                onTap: () {
                  if (context.read<FlagCubit>().state is FlagOn) {
                    context.read<SquareCubit>().setSquareFlagged();
                  } else {
                    GridInitial currentGridState =
                        context.read<GridCubit>().state as GridInitial;

                    context.read<SquareCubit>().openSquaresNeighborhood(
                        allSquareCubitsData:
                            currentGridState.allSquareCubitsData);
                  }
                },
                child: Container(
                  color: const Color.fromARGB(255, 202, 211, 210),
                )),
          );
          //
        } else if (state is SquareIsFlagged) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black)),
            child: InkWell(onTap: () {
              (context.read<FlagCubit>().state is FlagOn)
                  ? context.read<SquareCubit>().setSquareToInitial()
                  : null;
            },
                // wtf????????
                // context.read<FlagCubit>().state is! FlagOn
                //     ? context.read<SquareCubit>().setSquareToInitial
                //     : null,
                child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                  color: const Color.fromARGB(255, 202, 211, 210),
                  alignment: Alignment.center,
                  child: Icon(Icons.flag,
                      size: min(constraints.maxHeight / 3 * 2, 20)));
            })),
          );
        } else if (state is SquareIsSelected) {
          //--select
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 5, color: const Color.fromARGB(255, 253, 18, 1))),
            child: InkWell(
                onTap: () => null,
                child: Container(
                  color: const Color.fromARGB(255, 202, 211, 210),
                )),
          );
          //
        } else if (state is SquareIsVisible) {
          //--visib
          return LayoutBuilder(
            builder: (context, constraints) => Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black)),
              child: state.hasBomb
                  ? Container(
                      color: const Color.fromARGB(255, 236, 33, 19),
                      child: Icon(Icons.camera,
                          size: min(constraints.maxHeight / 3 * 2, 20)))
                  : state.bombsNear == 0
                      ? Container(
                          color: const Color.fromARGB(255, 110, 197, 187),
                        )
                      : Container(
                          // this container will be shown if bombs near are > 0
                          alignment: Alignment.center,
                          color: state.bombsNear == 1
                              ? const Color.fromARGB(255, 246, 233, 108)
                              : state.bombsNear == 2
                                  ? const Color.fromARGB(255, 111, 246, 118)
                                  : const Color.fromARGB(255, 99, 107, 224),
                          child: Text(
                            state.bombsNear.toString(),
                            style: TextStyle(
                                fontSize:
                                    min(constraints.maxHeight / 3 * 2, 20),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
            ),
          );
          //
        } else {
          //--not rly happenning
          return Container(
            color: const Color.fromARGB(255, 0, 0, 0),
          );
          //
        }
      },
    );
  }
}
