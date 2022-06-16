import 'package:flutter/Material.dart';

class TextInput extends StatefulWidget {
  final String label;
  final int id;
  final TextEditingController inputController;
  final Color unFocusedColor = const Color.fromARGB(255, 104, 104, 104);
  final Color focusedColor = const Color.fromARGB(255, 253, 92, 52);
  final double borderWidth = 2;

  const TextInput(
      {Key? key, this.label = "", this.id = 0, required this.inputController})
      : super(key: key);

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
