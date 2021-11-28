part of 'cpr_screen_cubit.dart';

abstract class CprScreenState extends Equatable {
  const CprScreenState();

  @override
  List<Object> get props => [];
}

class CprInitial extends CprScreenState {}

class CprProcessing extends CprScreenState {}

class CprProcessingSuccess extends CprScreenState {}

class CprProcessingError extends CprScreenState {
  final Failure failure;

  const CprProcessingError({required this.failure});

  @override
  List<Object> get props => [failure];
}
