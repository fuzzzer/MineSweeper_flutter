import 'package:flutter/Material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/logic/Cubits/timer_cubit/timer_cubit.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Bombs",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<GridCubit, GridState>(
                builder: (context, state) {
                  if (state is GridInitial) {
                    return Text(context.read<GridCubit>().bombsCount.toString(),
                        style:
                            const TextStyle(fontSize: 50, color: Colors.white));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
          BlocBuilder<TimerCubit, TimerState>(
            builder: (context, state) {
              if (state.currentTimerIsOn) {
                return RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${state.timeLeft}',
                        style: const TextStyle(color: Colors.red, fontSize: 30),
                      ),
                      const TextSpan(
                        text: 'sec',
                        style: TextStyle(
                          color: Color.fromARGB(222, 141, 128, 127),
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Icon(
                  CupertinoIcons.infinite,
                  color: Color.fromARGB(210, 206, 92, 84),
                  size: 50,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
