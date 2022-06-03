import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_refactored/ui/widgets/open_button.dart';
import 'mover.dart';

double minHeightLeft = 100; // this is minheight left to use contols

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isEnoughSpace = true;
      if (constraints.maxHeight < 150) isEnoughSpace = false;

      return isEnoughSpace
          ? Row(
              children: const [
                Mover(),
                OpenButton(),
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
