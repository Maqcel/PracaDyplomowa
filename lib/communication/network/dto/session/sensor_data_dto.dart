import 'package:json_annotation/json_annotation.dart';

part 'sensor_data_dto.g.dart';

@JsonSerializable()
class SensorDataDTO {
  @JsonKey(name: 'timestamp')
  final int timestamp;

  @JsonKey(name: 'xAxis')
  final double xAxis;

  @JsonKey(name: 'yAxis')
  final double yAxis;

  @JsonKey(name: 'zAxis')
  final double zAxis;

  const SensorDataDTO({
    required this.timestamp,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
  });

  factory SensorDataDTO.fromJson(Map<String, dynamic> json) =>
      _$SensorDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SensorDataDTOToJson(this);
}
