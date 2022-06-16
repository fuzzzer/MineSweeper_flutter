import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_refactored/logic/Cubits/drawer_cubit/drawer_cubit.dart';
import 'package:minesweeper_refactored/logic/Cubits/timer_cubit/timer_cubit.dart';
import 'package:minesweeper_refactored/ui/widgets/text_input.dart';
import '../../library/useful_methods.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInput time = TextInput(
      label: "Time",
      inputController: context.read<DrawerCubit>().timeInputController,
    );
    TextInput numberOfBombs = TextInput(
        label: "Number Of Bombs",
        inputController:
            context.read<DrawerCubit>().numberOfBombsInputController);
    TextInput squareSize = TextInput(
        label: "Square size",
        inputController: context.read<DrawerCubit>().squareSizeInputController);

    return SizedBox(
      height: 500,
      child: Column(children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: time),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: state.nextRoundTimerIsOn
                              ? ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(151, 112, 14, 7))
                              : ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(133, 5, 103, 8)),
                          onPressed: () =>
                              context.read<TimerCubit>().switchTimerMode(),
                          child: state.nextRoundTimerIsOn
                              ? const Text('off')
                              : const Text('on'),
                        );
                      },
                    ),
                  ),
                ],
              ),
              numberOfBombs,
              squareSize,
              ApplyButton(
                label: Row(
                  children: const [
                    Icon(Icons.restart_alt),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Restart"),
                      ),
                    ),
                  ],
                ),
                numberOfBombs: numberOfBombs,
                squareSize: squareSize,
                timeInput: time,
              ),
            ],
          ),
        ),
        const Notification(),
      ]),
    );
  }
}

class ApplyButton extends StatelessWidget {
  final Widget label;
  final TextInput numberOfBombs;
  final TextInput squareSize;
  final TextInput timeInput;

  const ApplyButton(
      {Key? key,
      this.label = const SizedBox.shrink(),
      required this.numberOfBombs,
      required this.squareSize,
      required this.timeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double widthLength;
          if (constraints.maxWidth > 400) {
            widthLength = 300;
          } else {
            widthLength = constraints.maxWidth * 3 / 4;
          }
          return SizedBox(
            width: widthLength,
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 228, 66, 55),
                onPrimary: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: label,
              onPressed: () {
                int bombSettings = 0;
                int sizeSettings = 0;
                int timeSettings = 0;

                if (isNumeric(timeInput.inputController.text)) {
                  timeSettings = int.parse(timeInput.inputController.text);
                }

                if (isNumeric(numberOfBombs.inputController.text)) {
                  bombSettings = int.parse(numberOfBombs.inputController.text);
                }

                if (isNumeric(squareSize.inputController.text)) {
                  sizeSettings = int.parse(squareSize.inputController.text);
                }

                context
                    .read<GridCubit>()
                    .setSettings(bombSettings, sizeSettings);

                context.read<TimerCubit>().setStartingTime(timeSettings);
              },
            ),
          );
        },
      ),
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 6, horizontal: 15),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: const Text(
          "Minimum number of Bombs is 1 and maximum total cells. Minumum Square size is 5 and Maximum 25. Minimum time is 10 seconds",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(135, 59, 59, 59),
          ),
        ),
      ),
    );
  }
}
