import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/core/global_variables.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

Future<dynamic> gameEndingDialog(context,
    {required String message, required Color textColor, bool reveal = false}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Text(message, style: TextStyle(color: textColor, fontSize: 30)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            computing = false;
            context.read<GridCubit>().updateGrid();
            Navigator.pop(context);
          },
          child: const Text('Play Again',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}
