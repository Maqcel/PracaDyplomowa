import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

abstract class AccelerometerSensorService {
  StreamSubscription<UserAccelerometerEvent> initAccelerometerSensorStream();

  bool isAccelerometerSensorWorking();

  void changeOnAccelerometerDataHandling(
      Function(UserAccelerometerEvent accelerometerEvent) onData);

  void pauseAccelerometerSensorStream();

  void resumeAccelerometerSensorStream();

  void disposeAccelerometerSensorStream();
}

abstract class GyroscopeSensorService {
  StreamSubscription<GyroscopeEvent> initGyroscopeSensorStream();

  bool isGyroscopeSensorWorking();

  void changeOnGyroscopeDataHandling(
      Function(GyroscopeEvent gyroscopeEvent) onData);

  void pauseGyroscopeSensorStream();

  void resumeGyroscopeSensorStream();

  void disposeGyroscopeSensorStream();
}
