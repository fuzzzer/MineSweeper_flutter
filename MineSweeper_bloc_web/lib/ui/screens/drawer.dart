import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../library/useful_methods.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInput numberOfBombs = TextInput(label: "Number Of Bombs");
    TextInput squareSize = TextInput(label: "Square size");

    return SizedBox(
      height: 500,
      child: Column(children: <Widget>[
        Expanded(
          child: Column(
            children: [
              numberOfBombs,
              squareSize,
              ApplyButton(
                label: "Apply",
                numberOfBombs: numberOfBombs,
                squareSize: squareSize,
              ),
            ],
          ),
        ),
        const Notification(),
      ]),
    );
  }
}

class TextInput extends StatefulWidget {
  final String label;
  final int id;
  final inputController = TextEditingController();
  final Color unFocusedColor = const Color.fromARGB(255, 104, 104, 104);
  final Color focusedColor = const Color.fromARGB(255, 253, 92, 52);
  final double borderWidth = 2;

  void dispose() {
    inputController.dispose();
  }

  TextInput({Key? key, this.label = "", this.id = 0}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: widget.inputController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.unFocusedColor, width: widget.borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.focusedColor, width: widget.borderWidth)),
          labelText: widget.label,
          labelStyle: TextStyle(color: widget.unFocusedColor),
        ),
      ),
    );
  }
}

class ApplyButton extends StatelessWidget {
  final String label;
  final TextInput numberOfBombs;
  final TextInput squareSize;

  const ApplyButton(
      {Key? key,
      this.label = "",
      required this.numberOfBombs,
      required this.squareSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double widthLength;
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
              child: Text(label),
              onPressed: () {
                int bombSettings = 0;
                int sizeSettings = 0;

                if (isNumeric(numberOfBombs.inputController.text)) {
                  bombSettings = int.parse(numberOfBombs.inputController.text);
                }

                if (isNumeric(squareSize.inputController.text)) {
                  sizeSettings = int.parse(squareSize.inputController.text);
                }

                context
                    .read<GridCubit>()
                    .setSettings(bombSettings, sizeSettings);
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
          "Number of Bombs should be more than 0 and less than total cells. Square size should be more than 4 and less than 26.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(135, 59, 59, 59)),
        ),
      ),
    );
  }
}
