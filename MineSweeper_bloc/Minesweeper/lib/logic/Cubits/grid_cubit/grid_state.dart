part of 'grid_cubit.dart';

abstract class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

class GridInitial extends GridState {
  final List<List<SquareCubit>> gridData;
  const GridInitial(this.gridData);

  @override
  List<Object> get props => [gridData];
}

class GridUpdating extends GridState {}
