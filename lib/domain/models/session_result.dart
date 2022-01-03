import 'package:equatable/equatable.dart';

class SessionResult extends Equatable {
  final DateTime sessionDate;
  final int numberOfChestCompressions;
  final double averageCompressionsRate;
  final List<double> temporaryCompressionRate;

  const SessionResult({
    required this.sessionDate,
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
  });

  @override
  List<Object> get props => [
        sessionDate,
        numberOfChestCompressions,
        averageCompressionsRate,
        temporaryCompressionRate,
      ];
}
