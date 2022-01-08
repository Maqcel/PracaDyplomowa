import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/network/dto/session/sensor_data_dto.dart';
import 'package:praca_inz/communication/network/dto/session/session_result_dto.dart';
import 'package:praca_inz/domain/models/sensor_data.dart';

class SessionResult extends Equatable {
  final DateTime sessionDate;
  final int numberOfChestCompressions;
  final double averageCompressionsRate;
  final List<double> temporaryCompressionRate;
  final List<SensorData> rawData;

  const SessionResult({
    required this.sessionDate,
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
    required this.rawData,
  });

  factory SessionResult.fromDTO(SessionResultDTO dto) => SessionResult(
        sessionDate: dto.sessionDate,
        numberOfChestCompressions: dto.numberOfChestCompressions,
        averageCompressionsRate: dto.averageCompressionsRate,
        temporaryCompressionRate: dto.temporaryCompressionRate,
        rawData: dto.rawData
            .map((dto) => SensorData.fromDTO(SensorDataDTO.fromJson(dto)))
            .toList(),
      );

  @override
  List<Object> get props => [
        sessionDate,
        numberOfChestCompressions,
        averageCompressionsRate,
        temporaryCompressionRate,
        rawData,
      ];
}
