import 'package:equatable/equatable.dart';
import 'package:praca_inz/communication/network/dto/session/sensor_data_dto.dart';

class SensorData extends Equatable {
  final int timestamp;
  final double xAxis;
  final double yAxis;
  final double zAxis;

  const SensorData({
    required this.timestamp,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
  });

  /// Look into [SensorDataDTO] for more explanation about those comments
  factory SensorData.fromDTO(SensorDataDTO dto) => SensorData(
        timestamp: dto.timestamp,
        xAxis: 0.0, // dto.xAxis,
        yAxis: 0.0, // dto.yAxis,
        zAxis: dto.zAxis,
      );

  @override
  List<Object> get props => [
        timestamp,
        xAxis,
        yAxis,
        zAxis,
      ];
}
