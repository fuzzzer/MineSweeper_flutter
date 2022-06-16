import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

Future<dynamic> gameEndingDialog(context,
    {required final String message, required final Color textColor}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Text(message, style: TextStyle(color: textColor, fontSize: 30)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            context
                .read<GridCubit>()
                .setUpdating(); //TODO: updatefrom here and not from state
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
