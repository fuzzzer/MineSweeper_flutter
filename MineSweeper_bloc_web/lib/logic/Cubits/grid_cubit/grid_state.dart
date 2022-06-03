part of 'grid_cubit.dart';

abstract class GridState extends Equatable {
  const GridState();

  @override
  List<Object> get props => [];
}

class GridInitial extends GridState {
  final List<List<SquareCubit>> allSquareCubitsData;
  const GridInitial(this.allSquareCubitsData);

  @override
  List<Object> get props => [allSquareCubitsData];
}

class GridUpdated extends GridState {}
