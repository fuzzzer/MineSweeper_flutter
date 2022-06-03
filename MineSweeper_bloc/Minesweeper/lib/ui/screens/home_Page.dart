import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/logic/Cubits/grid_cubit/grid_cubit.dart';
import 'package:minesweeper_refactored/ui/widgets/options_on_top.dart';
import '../../core/info.dart';
import '../widgets/grid.dart';
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
          child: Stack(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  children: [
                    const Expanded(
                      child: OptionsOnTop(),
                      flex: 2,
                    ),
                    Expanded(
                        child: BlocBuilder<GridCubit, GridState>(
                          builder: (context, state) {
                            if (state is GridInitial) {
                              // final ScrollController _scrollController =
                              //     ScrollController();
                              return
                                  // Scrollbar(
                                  //     thickness: 40,
                                  //     controller: _scrollController,
                                  //     thumbVisibility: true,
                                  //     child:
                                  Grid(gridData: state.gridData);
                              // );
                            } else {
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
                        flex: 4),
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
    );
  }
}
