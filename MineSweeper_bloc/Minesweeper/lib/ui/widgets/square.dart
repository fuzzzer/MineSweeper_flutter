import 'dart:math';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/logic/Cubits/square_selector_cubit/square_selector_cubit.dart';
import '../../logic/Cubits/square_cubit/square_cubit.dart';

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: BlocBuilder<SquareCubit, SquareState>(
                  builder: (context, state) {
                if (state is SquareInitial) {
                  return Container(
                    color: const Color.fromARGB(255, 202, 211, 210),
                  );
                } else if (state is SquareIsVisible) {
                  return LayoutBuilder(
                    builder: (context, constraints) => Container(
                      child: state.hasBomb
                          ? Container(
                              color: const Color.fromARGB(255, 236, 33, 19),
                              child: Icon(Icons.camera,
                                  size: min(constraints.maxHeight / 3 * 2, 20)))
                          : state.bombsNear == 0
                              ? Container(
                                  color:
                                      const Color.fromARGB(255, 110, 197, 187),
                                )
                              : Container(
                                  // this container will be shown if bombs near are > 0
                                  alignment: Alignment.center,
                                  color: state.bombsNear == 1
                                      ? const Color.fromARGB(255, 246, 233, 108)
                                      : state.bombsNear == 2
                                          ? const Color.fromARGB(
                                              255, 111, 246, 118)
                                          : const Color.fromARGB(
                                              255, 99, 107, 224),
                                  child: Text(
                                    state.bombsNear.toString(),
                                    style: TextStyle(
                                        fontSize: min(
                                            constraints.maxHeight / 3 * 2, 20),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                    ),
                  );
                } else {
                  return Container(
                    color: const Color.fromARGB(255, 202, 211, 210),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.flag,
                      size: min(constraints.maxHeight / 3 * 2, 20),
                    ),
                  );
                }
              }),
            ),
          ),
          BlocBuilder<SquareSelectorCubit, SquareSelectorState>(
              builder: (context, state) {
            if (state is SquareIsNotSelected) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: const Color.fromARGB(255, 2, 2, 2)),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color: const Color.fromARGB(255, 253, 18, 1)),
                ),
              );
            }
          }),
        ],
      );
    });
  }
}
