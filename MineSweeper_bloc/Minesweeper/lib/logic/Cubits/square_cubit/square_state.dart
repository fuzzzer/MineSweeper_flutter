part of 'square_cubit.dart';

@immutable
abstract class SquareState extends Equatable {
  const SquareState();

  @override
  List<Object> get props => [];
}

class SquareInitial extends SquareState {}

class SquareIsFlagged extends SquareState {}

class SquareIsVisible extends SquareState {
  final bool hasBomb;
  final int bombsNear;

  const SquareIsVisible({required this.hasBomb, required this.bombsNear});

  @override
  List<Object> get props => [hasBomb, bombsNear];
}
