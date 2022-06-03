part of 'flag_cubit.dart';

abstract class FlagState extends Equatable {
  const FlagState();

  @override
  List<Object> get props => [];
}

class FlagOn extends FlagState {}

class FlagOff extends FlagState {}
