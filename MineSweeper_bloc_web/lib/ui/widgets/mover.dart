import 'dart:math';

import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/core/info.dart';

import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

class Mover extends StatelessWidget {
  const Mover({Key? key}) : super(key: key);

  final double padding = 8;
  @override
  Widget build(BuildContext context) {
    double widthLength = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    widthLength = min(screenWidth, maxWidth) / 3 * 2;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            height: constraints.maxHeight,
            width: widthLength,
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.globalPosition.dx > padding &&
                    details.globalPosition.dx < padding + widthLength &&
                    details.globalPosition.dy >
                        screenHeight - (padding + constraints.maxHeight) &&
                    details.globalPosition.dy < screenHeight - padding) {
                  context
                      .read<GridCubit>()
                      .onPanUpdate(details, widthLength, constraints.maxHeight);
                }
              },
              child: Material(
                elevation: 10,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(162, 231, 204, 122)),
                  child: Column(
                    children: const [
                      Text(
                        "slide",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
