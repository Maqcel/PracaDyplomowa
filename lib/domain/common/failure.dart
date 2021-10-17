import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String? message;
  final Exception? cause;

  const Failure({this.message, this.cause});

  factory Failure.unexpected({Exception? cause}) => UnexpectedFailure(
        cause: cause,
      );

  @override
  String toString() => '$runtimeType: $message';

  @override
  List<Object?> get props => [
        message,
        cause,
      ];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String? message, Exception? cause})
      : super(
          message: message ?? 'An unexpected error has occurred',
          cause: cause,
        );
}
