import 'dart:async';

import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerSensor extends AccelerometerSensorService {
  late StreamSubscription<UserAccelerometerEvent> _accelerometerStream;

  @override
  StreamSubscription<UserAccelerometerEvent> initAccelerometerSensorStream() =>
      _accelerometerStream = userAccelerometerEvents.listen(
        (event) {},
        cancelOnError: true,
      );

  @override
  bool isAccelerometerSensorWorking() => !_accelerometerStream.isPaused;

  @override
  void changeOnAccelerometerDataHandling(
          Function(UserAccelerometerEvent accelerometerEvent) onData) =>
      _accelerometerStream.onData((data) => onData(data));

  @override
  void pauseAccelerometerSensorStream() => _accelerometerStream.pause();

  @override
  void resumeAccelerometerSensorStream() => _accelerometerStream.resume();

  @override
  void disposeAccelerometerSensorStream() => _accelerometerStream.cancel();
}
