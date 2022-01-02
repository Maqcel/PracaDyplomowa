import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

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

  SessionResultDTO({
    required this.sessionDate,
    required this.numberOfChestCompressions,
    required this.averageCompressionsRate,
    required this.temporaryCompressionRate,
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
