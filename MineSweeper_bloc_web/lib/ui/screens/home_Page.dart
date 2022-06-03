import 'package:flutter/material.dart';
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
      drawer: const Drawer(child: Settings()),
      body: Stack(children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              children: const [
                Expanded(
                  child: OptionsOnTop(),
                ),
                Expanded(child: Grid(), flex: 4),
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
    );
  }
}
