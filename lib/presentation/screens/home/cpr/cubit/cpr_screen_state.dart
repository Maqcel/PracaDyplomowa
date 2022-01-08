part of 'cpr_screen_cubit.dart';

abstract class CprScreenState extends Equatable {
  const CprScreenState();

  @override
  List<Object> get props => [];
}

class CprInitial extends CprScreenState {}

class CprInformation extends CprScreenState {
  final bool shouldShowCprInstruction;

  const CprInformation({required this.shouldShowCprInstruction});

  @override
  List<Object> get props => [shouldShowCprInstruction];
}

class CprSessionWaiting extends CprScreenState {}

class CprSessionProgress extends CprScreenState {
  final int timeLeft;
  final SessionResult currentResults;

  const CprSessionProgress({
    required this.timeLeft,
    required this.currentResults,
  });

  CprSessionProgress copyWith({
    int? timeLeft,
    SessionResult? currentResults,
  }) =>
      CprSessionProgress(
        timeLeft: timeLeft ?? this.timeLeft,
        currentResults: currentResults ?? this.currentResults,
      );

  @override
  List<Object> get props => [
        timeLeft,
        currentResults,
      ];
}

class CprSessionSubmit extends CprScreenState {
  final SessionResult sessionResult;

  const CprSessionSubmit({required this.sessionResult});

  @override
  List<Object> get props => [sessionResult];
}

class CprSubmitError extends CprScreenState {
  final Failure failure;

  const CprSubmitError({required this.failure});

  @override
  List<Object> get props => [failure];
}
