import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/Cubits/flag_cubit/flag_cubit.dart';

class Flag extends StatefulWidget {
  final double iconSize = 50;

  const Flag({Key? key}) : super(key: key);

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
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
                iconSize: widget.iconSize,
                icon: Icon(
                  Icons.flag,
                  color: Colors.red,
                  size: widget.iconSize,
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
                iconSize: widget.iconSize,
                icon: Icon(
                  Icons.flag,
                  color: Colors.green,
                  size: widget.iconSize,
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
