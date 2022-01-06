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

class CprSessionStart extends CprScreenState {}

class CprSessionWaiting extends CprScreenState {}

class CprSessionProgress extends CprScreenState {}

class CprSessionSuccess extends CprScreenState {}

class CprSessionSubmit extends CprScreenState {}

class CprSubmitError extends CprScreenState {
  final Failure failure;

  const CprSubmitError({required this.failure});

  @override
  List<Object> get props => [failure];
}
