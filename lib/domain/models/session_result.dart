import 'package:equatable/equatable.dart';

class SessionResult extends Equatable {
  final int numberOfChestCompressions;
  final double averageCompressionsRate;
  final List<double> temporaryCompressionRate;

  const SessionResult({
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
  });

  @override
  List<Object> get props => [
        numberOfChestCompressions,
        averageCompressionsRate,
        temporaryCompressionRate,
      ];
}
