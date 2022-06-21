import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit({
    required this.startingTime,
    required bool currentTimerIsOn,
    required bool nextRoundTimerIsOn,
  }) : super(TimerState(
            timeLeft: startingTime,
            currentTimerIsOn: currentTimerIsOn,
            nextRoundTimerIsOn: nextRoundTimerIsOn));

  int startingTime = 0;

  Timer? timer;

  void switchTimerMode() {
    if (state.nextRoundTimerIsOn) {
      emit(state.copyWith(nextRoundTimerIsOn: false));
    } else {
      emit(state.copyWith(nextRoundTimerIsOn: true));
    }
  }

  void setStartingTime(int newStartingTime) {
    if (newStartingTime >= 10) {
      startingTime = newStartingTime;
    }
  }

  void runTimer({int? newStartingTime}) {
    if (timer != null) {
      timer!.cancel();
      emit(state.copyWith(currentTimerIsOn: false));
    }
    if (state.nextRoundTimerIsOn) {
      int timeLeft = startingTime;

      emit(state.copyWith(currentTimerIsOn: true, timeLeft: timeLeft));

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft--;

        emit(state.copyWith(timeLeft: timeLeft));
        if (timeLeft == 0) {
          emit(state.copyWith(currentTimerIsOn: false));
          timer.cancel();
        }
      });
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
      //emit(state.copyWith(currentTimerIsOn: false));
    }
  }
}
