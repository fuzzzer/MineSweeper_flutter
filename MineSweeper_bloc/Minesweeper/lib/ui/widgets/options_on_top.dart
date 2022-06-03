import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/ui/widgets/flag.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';
import 'game_ending_dialog.dart';

class OptionsOnTop extends StatelessWidget {
  const OptionsOnTop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const Flag(),
          ),
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
          Container(
            alignment: Alignment.center,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color.fromARGB(111, 240, 55, 31).withOpacity(0.5),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: const Icon(Icons.restart_alt,
                    size: 55, color: Color.fromARGB(255, 0, 0, 0)),
                onTap: () => gameEndingDialog(context,
                    textColor: Colors.red, message: 'Are you sure?'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
