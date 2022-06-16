part of 'timer_cubit.dart';

@immutable
class TimerState extends Equatable {
  final int timeLeft;
  final bool currentTimerIsOn;
  final bool nextRoundTimerIsOn;
  const TimerState(
      {required this.timeLeft,
      required this.currentTimerIsOn,
      required this.nextRoundTimerIsOn});

  @override
  List<Object> get props => [timeLeft, currentTimerIsOn, nextRoundTimerIsOn];

  TimerState copyWith({
    int? timeLeft,
    bool? currentTimerIsOn,
    bool? nextRoundTimerIsOn,
  }) {
    return TimerState(
      timeLeft: timeLeft ?? this.timeLeft,
      currentTimerIsOn: currentTimerIsOn ?? this.currentTimerIsOn,
      nextRoundTimerIsOn: nextRoundTimerIsOn ?? this.nextRoundTimerIsOn,
    );
  }
}
