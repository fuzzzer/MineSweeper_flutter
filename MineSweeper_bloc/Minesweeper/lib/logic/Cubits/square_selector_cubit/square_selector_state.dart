part of 'square_selector_cubit.dart';

abstract class SquareSelectorState extends Equatable {
  const SquareSelectorState();

  @override
  List<Object> get props => [];
}

class SquareIsNotSelected extends SquareSelectorState {}

class SquareIsSelected extends SquareSelectorState {}
