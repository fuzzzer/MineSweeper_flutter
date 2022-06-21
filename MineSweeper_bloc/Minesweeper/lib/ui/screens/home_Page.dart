import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/core/info.dart';
import 'package:minesweeper_refactored/logic/Cubits/grid_cubit/grid_cubit.dart';
import 'package:minesweeper_refactored/logic/Cubits/timer_cubit/timer_cubit.dart';
import 'package:minesweeper_refactored/ui/widgets/options_on_top.dart';
import 'package:minesweeper_refactored/ui/widgets/playground.dart';

import 'drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),
      key: scaffoldKey,
      drawer: const SafeArea(child: Drawer(child: Settings())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      const Expanded(
                        child: TopRow(),
                        flex: 2,
                      ),
                      Expanded(
                        flex: 8,
                        child: BlocListener<TimerCubit, TimerState>(
                          listener: (context, state) {
                            if (state.currentTimerIsOn) {
                              if (state.timeLeft == 0) {
                                context.read<GridCubit>().timeOut();
                                context.read<TimerCubit>().cancelTimer();
                              }
                            }
                          },
                          child: BlocBuilder<GridCubit, GridState>(
                            builder: (context, state) {
                              if (state is GridInitial) {
                                return Playground(gridData: state.gridData);
                              } else {
                                context.read<TimerCubit>().runTimer();

                                context.read<GridCubit>().updateGrid();
                                return const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(226, 194, 48, 38),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => scaffoldKey.currentState?.openDrawer(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
