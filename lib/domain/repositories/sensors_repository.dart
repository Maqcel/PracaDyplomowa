import 'dart:developer';

import 'package:moving_average/moving_average.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/di/service_locator.dart';
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

  void onCprSessionStart() {
    ServiceLocator.get<AccelerometerSensorService>()
        .initAccelerometerSensorStream();
    ServiceLocator.get<GyroscopeSensorService>().initGyroscopeSensorStream();
    log('Sensors: Enabled\nSession: Starting');
    _accelerometerSensor.changeOnAccelerometerDataHandling(
      (accelerometerEvent) => _events.add(
        SensorData(
          timestamp: DateTime.now().microsecondsSinceEpoch,
          xAxis: accelerometerEvent.x,
          yAxis: accelerometerEvent.y,
          zAxis: accelerometerEvent.z,
        ),
      ),
    );
  }

  void onCprSessionEnd() {
    ServiceLocator.get<AccelerometerSensorService>()
        .disposeAccelerometerSensorStream();
    ServiceLocator.get<GyroscopeSensorService>().disposeGyroscopeSensorStream();
    log('Session: Ended\nSensors:Disabled');

    final MovingAverage<SensorData> _exponentialMovingAverage =
        MovingAverage<SensorData>(
      averageType: AverageType.exponential,
      factor: 0.05,
      getValue: (sensorData) => sensorData.zAxis,
      add: (data, value) => SensorData(
        timestamp: data.last.timestamp,
        xAxis: data.last.xAxis,
        yAxis: data.last.yAxis,
        zAxis: value.toDouble(),
      ),
    );

    final List<SensorData> _filteredEvents = _exponentialMovingAverage(_events);
    log('Filtered By Exponential Moving Average factor: 0.05');
    for (var i = 0; i < _events.length; i++) {
      log('${_filteredEvents[i].timestamp - _filteredEvents.first.timestamp}\t${_filteredEvents[i].zAxis}');
    }
  }

  void printRaw() {
    log('Raw data from accelerator');
    for (var i = 0; i < _events.length; i++) {
      log('${_events[i].timestamp - _events.first.timestamp}\t${_events[i].zAxis}');
    }
  }

  void onGyroscopeDataStartPrinting() =>
      _gyroscopeSensor.changeOnGyroscopeDataHandling(_logGyroscopeData);

  void _logGyroscopeData(GyroscopeEvent gyroscopeEvent) =>
      log('Gyroscope Event: ' + gyroscopeEvent.toString());

  void changeAccelerometerStreamState() =>
      _accelerometerSensor.isAccelerometerSensorWorking()
          ? _accelerometerSensor.pauseAccelerometerSensorStream()
          : _accelerometerSensor.resumeAccelerometerSensorStream();

  void changeGyroscopeStreamState() =>
      _gyroscopeSensor.isGyroscopeSensorWorking()
          ? _gyroscopeSensor.pauseGyroscopeSensorStream()
          : _gyroscopeSensor.resumeGyroscopeSensorStream();
}
