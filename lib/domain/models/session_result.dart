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

  double calculateSessionGrade() {
    double grade = 0.0;

    // 50% of grade number of compressions in range
    if (numberOfChestCompressions > 120) {
      grade += 50.0 - 50.0 * ((numberOfChestCompressions - 120) / 120);
    } else if (numberOfChestCompressions < 100 &&
        numberOfChestCompressions > 50) {
      grade += 50.0 - 50.0 * (numberOfChestCompressions / 100);
    } else if (numberOfChestCompressions > 100) {
      grade += 50.0;
    }

    // 30% of grade for average in range
    if (averageCompressionsRate > 120) {
      grade += 30.0 - 30.0 * ((averageCompressionsRate - 120) / 120);
    } else if (averageCompressionsRate < 100 && averageCompressionsRate > 50) {
      grade += 30.0 - 30.0 * (averageCompressionsRate / 100);
    } else if (averageCompressionsRate > 100) {
      grade += 30.0;
    }

    if (temporaryCompressionRate.isEmpty) return grade;

    // 20% for temporary measurements
    int fractionOf = temporaryCompressionRate.length;
    double eachRateGradeValue = 20 / fractionOf;

    for (double rate in temporaryCompressionRate) {
      if (rate > 120) {
        grade += eachRateGradeValue - eachRateGradeValue * ((rate - 120) / 120);
      } else if (rate < 100) {
        grade += eachRateGradeValue - eachRateGradeValue * (rate / 100);
      } else {
        grade += eachRateGradeValue;
      }
    }

    return grade;
  }

  @override
  List<Object> get props => [
        sessionDate,
        numberOfChestCompressions,
        averageCompressionsRate,
        temporaryCompressionRate,
        rawData,
      ];
}
