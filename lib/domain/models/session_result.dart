import 'package:equatable/equatable.dart';
import 'package:praca_inz/domain/models/sensor_data.dart';

class SessionResult extends Equatable {
  final DateTime sessionDate;
  final int numberOfChestCompressions;
  final double averageCompressionsRate;
  final List<double> temporaryCompressionRate;
  final List<SensorData>? rawData;
  final List<SensorData>? filteredData;

  const SessionResult({
    required this.sessionDate,
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
    this.rawData,
    this.filteredData,
  });

  @override
  List<Object?> get props => [
        sessionDate,
        numberOfChestCompressions,
        averageCompressionsRate,
        temporaryCompressionRate,
        rawData,
        filteredData,
      ];
}
