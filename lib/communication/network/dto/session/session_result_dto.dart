import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:praca_inz/communication/network/dto/session/sensor_data_dto.dart';

part 'session_result_dto.g.dart';

@JsonSerializable()
class SessionResultDTO {
  @TimestampConverter()
  final DateTime sessionDate;

  @JsonKey(name: 'numberOfChestCompressions')
  final int numberOfChestCompressions;

  @JsonKey(name: 'averageCompressionsRate')
  final double averageCompressionsRate;

  @JsonKey(name: 'temporaryCompressionRate', defaultValue: [])
  final List<double> temporaryCompressionRate;

  @JsonKey(name: 'rawData', defaultValue: [])
  final List<SensorDataDTO>? rawData;

  @JsonKey(name: 'filteredData', defaultValue: [])
  final List<SensorDataDTO>? filteredData;

  SessionResultDTO({
    required this.sessionDate,
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
    this.rawData,
    this.filteredData,
  });

  factory SessionResultDTO.fromJson(Map<String, dynamic> json) =>
      _$SessionResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SessionResultDTOToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
