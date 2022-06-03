import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/core/info.dart';
import 'package:minesweeper_refactored/core/keys.dart';
import 'package:minesweeper_refactored/logic/Cubits/flag_cubit/flag_cubit.dart';
import 'package:minesweeper_refactored/logic/Cubits/grid_cubit/grid_cubit.dart';
import 'logic/global_logics/initialize_squares_cubit_matrix.dart';
import 'ui/screens/home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GridCubit(
              gridData: initializedCubitsForGrid(
                  startingBombsCount, startingSizesOfGrid)),
        ),
        BlocProvider(
          create: (context) => FlagCubit(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'MineSweeper',
        theme: ThemeData(),
        home: HomePage(),
      ),
    );
  }
}
