part of 'cpr_screen_cubit.dart';

abstract class CprScreenState extends Equatable {
  const CprScreenState();

  @override
  List<Object> get props => [];
}

class CprInformation extends CprScreenState {}

class CprSessionStart extends CprScreenState {}

class CprSessionProgress extends CprScreenState {}

class CprSessionSuccess extends CprScreenState {}

class CprSessionSubmit extends CprScreenState {}

class CprSubmitError extends CprScreenState {
  final Failure failure;

  const CprSubmitError({required this.failure});

  @override
  List<Object> get props => [failure];
}
