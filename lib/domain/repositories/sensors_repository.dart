import 'dart:developer';
import 'package:collection/collection.dart';

import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/domain/models/sensor_data.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsRepository {
  final AccelerometerSensorService _accelerometerSensor;
  final GyroscopeSensorService _gyroscopeSensor;
  final List<SensorData> _events = [];

  SensorsRepository({
    required AccelerometerSensorService accelerometerSensor,
    required GyroscopeSensorService gyroscopeSensor,
  })  : _accelerometerSensor = accelerometerSensor,
        _gyroscopeSensor = gyroscopeSensor;

  void onAccelerometerDataStartPrinting() => _accelerometerSensor
      .changeOnAccelerometerDataHandling(_logAccelerometerData);

  void _logAccelerometerData(UserAccelerometerEvent accelerometerEvent) {
    log('Accelerometer Event: ' + accelerometerEvent.toString());
    _events.add(SensorData(
      timestamp: DateTime.now().microsecondsSinceEpoch,
      xAxis: accelerometerEvent.x,
      yAxis: accelerometerEvent.y,
      zAxis: accelerometerEvent.z,
    ));
  }

  void onGyroscopeDataStartPrinting() =>
      _gyroscopeSensor.changeOnGyroscopeDataHandling(_logGyroscopeData);

  void _logGyroscopeData(GyroscopeEvent gyroscopeEvent) =>
      log('Gyroscope Event: ' + gyroscopeEvent.toString());

  void changeAccelerometerStreamState() =>
      _accelerometerSensor.isAccelerometerSensorWorking()
          ? _accelerationSensorsDataRevision()
          : _accelerometerSensor.resumeAccelerometerSensorStream();

  void _accelerationSensorsDataRevision() {
    _accelerometerSensor.pauseAccelerometerSensorStream();
    log('Acceleration Data:');
    log(_events.length.toString());
    log('Max zAxis: ${_events.reduce((current, next) => current.zAxis > next.zAxis ? current : next).toString()}');
    log('Min zAxis: ${_events.reduce((current, next) => current.zAxis < next.zAxis ? current : next).toString()}');

    List<SensorData> _ascendingValues =
        _events.where((data) => data.zAxis > 0.1).toList();
    List<SensorData> _descendingValues =
        _events.where((data) => data.zAxis < -0.1).toList();

    _descendingValues.sort((a, b) => a.zAxis.compareTo(b.zAxis));
    _ascendingValues.sort((a, b) => a.zAxis.compareTo(b.zAxis));

    log('Average ascending zAxis: ${_ascendingValues.map((data) => data.zAxis).average}');
    log('Average descending zAxis: ${_descendingValues.map((data) => data.zAxis).average}');

    double zAxisMedianAsc = _ascendingValues.length.isEven
        ? (_ascendingValues[_ascendingValues.length ~/ 2 - 1].zAxis +
                _ascendingValues[_ascendingValues.length ~/ 2].zAxis) /
            2.0
        : _ascendingValues[_ascendingValues.length ~/ 2].zAxis;

    double zAxisMedianDsc = _descendingValues.length.isEven
        ? (_descendingValues[_descendingValues.length ~/ 2 - 1].zAxis +
                _descendingValues[_descendingValues.length ~/ 2].zAxis) /
            2.0
        : _descendingValues[_descendingValues.length ~/ 2].zAxis;

    log('Median ascending zAxis: $zAxisMedianAsc');
    log('Median descending zAxis: $zAxisMedianDsc');

    _events.clear();
  }

  void changeGyroscopeStreamState() =>
      _gyroscopeSensor.isGyroscopeSensorWorking()
          ? _gyroscopeSensor.pauseGyroscopeSensorStream()
          : _gyroscopeSensor.resumeGyroscopeSensorStream();
}
