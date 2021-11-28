import 'package:equatable/equatable.dart';

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

  @override
  List<Object> get props => [
        timestamp,
        xAxis,
        yAxis,
        zAxis,
      ];
}
