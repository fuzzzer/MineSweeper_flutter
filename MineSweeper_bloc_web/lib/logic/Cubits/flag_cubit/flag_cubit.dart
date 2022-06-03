import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'flag_state.dart';

class FlagCubit extends Cubit<FlagState> {
  FlagCubit() : super(FlagOff());

  void setFlagOn() {
    emit(FlagOn());
  }

  void setFlagOff() {
    emit(FlagOff());
  }
}
