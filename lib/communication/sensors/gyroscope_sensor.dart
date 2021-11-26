import 'dart:async';

import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensor implements GyroscopeSensorService {
  late StreamSubscription<GyroscopeEvent> _gyroscopeStream;

  @override
  StreamSubscription<GyroscopeEvent> initGyroscopeSensorStream() =>
      _gyroscopeStream = gyroscopeEvents.listen(
        (event) {},
        cancelOnError: true,
      );

  @override
  bool isGyroscopeSensorWorking() => !_gyroscopeStream.isPaused;

  @override
  void changeOnGyroscopeDataHandling(
          Function(GyroscopeEvent gyroscopeEvent) onData) =>
      _gyroscopeStream.onData((data) => onData(data));

  @override
  void pauseGyroscopeSensorStream() => _gyroscopeStream.pause();

  @override
  void resumeGyroscopeSensorStream() => _gyroscopeStream.resume();

  @override
  void disposeGyroscopeSensorStream() => _gyroscopeStream.cancel();
}
