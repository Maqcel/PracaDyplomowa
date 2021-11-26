import 'dart:developer';

import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsRepository {
  final AccelerometerSensorService _accelerometerSensor;
  final GyroscopeSensorService _gyroscopeSensor;

  SensorsRepository({
    required AccelerometerSensorService accelerometerSensor,
    required GyroscopeSensorService gyroscopeSensor,
  })  : _accelerometerSensor = accelerometerSensor,
        _gyroscopeSensor = gyroscopeSensor;

  void onAccelerometerDataStartPrinting() => _accelerometerSensor
      .changeOnAccelerometerDataHandling(_logAccelerometerData);

  void _logAccelerometerData(UserAccelerometerEvent accelerometerEvent) =>
      log('Accelerometer Event: ' + accelerometerEvent.toString());

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
