part of 'square_cubit.dart';

@immutable
abstract class SquareState {}

class SquareInitial extends SquareState {}

class SquareIsSelected extends SquareState {}

class SquareIsFlagged extends SquareState {}

class SquareIsVisible extends SquareState {
  final bool hasBomb;
  final int bombsNear;
  SquareIsVisible({required this.hasBomb, required this.bombsNear});
  List<Object> get props => [hasBomb, bombsNear];
}
