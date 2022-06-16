import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/Cubits/flag_cubit/flag_cubit.dart';

class Flag extends StatelessWidget {
  final double iconSize = 70;

  const Flag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlagCubit, FlagState>(
      builder: (context, state) {
        if (state is FlagOff) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                splashColor: Colors.black,
                iconSize: iconSize,
                icon: Icon(
                  Icons.flag,
                  color: const Color.fromARGB(158, 244, 67, 54),
                  size: iconSize,
                ),
                onPressed: () => context.read<FlagCubit>().setFlagOn(),
              ),
              const Text("off",
                  style: TextStyle(
                      color: Color.fromARGB(255, 155, 144, 144),
                      fontWeight: FontWeight.w800))
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                splashColor: Colors.black,
                iconSize: iconSize,
                icon: Icon(
                  Icons.flag,
                  color: const Color.fromARGB(141, 76, 175, 79),
                  size: iconSize,
                ),
                onPressed: () => context.read<FlagCubit>().setFlagOff(),
              ),
              const Text("on",
                  style: TextStyle(
                      color: Color.fromARGB(255, 155, 144, 144),
                      fontWeight: FontWeight.w800))
            ],
          );
        }
      },
    );
  }
}
