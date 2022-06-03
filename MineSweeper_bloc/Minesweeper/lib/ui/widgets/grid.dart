import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_refactored/core/keys.dart';
import 'package:minesweeper_refactored/ui/widgets/square.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../../logic/Cubits/flag_cubit/flag_cubit.dart';
import '../../logic/Cubits/grid_cubit/grid_cubit.dart';
import '../../logic/Cubits/square_cubit/square_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grid extends StatelessWidget {
  const Grid({Key? key, required final this.gridData}) : super(key: key);

  final List<List<SquareCubit>> gridData;

  @override
  Widget build(BuildContext context) {
    final int gridSize = gridData.length;
    final ScrollController _scrollController = ScrollController();

    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.height,
            maxHeight: MediaQuery.of(context).size.width),
        child: GestureDetector(
          key: globalKey,
          onTapDown: (details) {
            final RenderBox renderBox =
                globalKey.currentContext?.findRenderObject() as RenderBox;
            final Offset offset = renderBox.localToGlobal(Offset.zero);

            context.read<GridCubit>().handleOneTap(
                details,
                offset,
                constraints
                    .maxWidth); //because grid max width because height is equal t it
          },
          onDoubleTap: () {
            if (context.read<FlagCubit>().state is FlagOn) {
              context.read<GridCubit>().switchFlag();
            } else {
              context.read<GridCubit>().openSquaresNeighborhood();
            }
          },
          onPanUpdate: (details) {
            final RenderBox renderBox =
                globalKey.currentContext?.findRenderObject() as RenderBox;

            final Offset offset = renderBox.localToGlobal(Offset.zero);
            if (details.globalPosition.dx > offset.dx &&
                details.globalPosition.dx < offset.dx + constraints.maxWidth &&
                details.globalPosition.dy > offset.dy &&
                details.globalPosition.dy <
                    offset.dy +
                        constraints
                            .maxHeight) // using maxWidth because width and height are the same and width of this widget is expanded till the end
            {
              context.read<GridCubit>().onPanUpdate(
                  details, constraints.maxWidth, constraints.maxHeight);
            }
          },
          child: SingleChildScrollView(
            //physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    return Container(
                      alignment: Alignment.center,
                      child: DraggableScrollbar.semicircle(
                        controller: _scrollController,
                        child: GridView.count(
                          controller: _scrollController,
                          shrinkWrap: true,
                          crossAxisCount: gridSize,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List<Widget>.generate(
                            gridSize * gridSize,
                            (index) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<SquareCubit>(
                                    // this is not getting rebuilt when I emit two consecuive states from bloc.updateGrid(), but it gets rebuilt if I emit new state from gridUpdating state
                                    create: (context) {
                                      return gridData[index ~/ gridSize]
                                          [index % gridSize];
                                    },
                                  ),
                                  BlocProvider(
                                    create: (context) {
                                      return gridData[index ~/ gridSize]
                                              [index % gridSize]
                                          .selector;
                                    },
                                  ),
                                ],
                                child: const Square(),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 150,
                  child: Container(
                    color: const Color.fromARGB(
                        255, 19, 18, 18), // color of the homepagebackground
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
