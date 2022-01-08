import 'dart:developer' as log;
import 'dart:math';
import 'package:collection/collection.dart';

import 'package:moving_average/moving_average.dart';
import 'package:praca_inz/communication/sensors/sensors_services.dart';
import 'package:praca_inz/di/service_locator.dart';
import 'package:praca_inz/domain/models/sensor_data.dart';
import 'package:praca_inz/domain/models/session_result.dart';

class SensorsRepository {
  final AccelerometerSensorService _accelerometerSensor;
  final GyroscopeSensorService _gyroscopeSensor;

  final num microsecondsToMinutes = 60 * pow(10, 6);
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
    log.log('Sensors: Enabled\nSession: Starting');
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
    log.log('Session: Ended\nSensors:Disabled');

    _events.clear();
  }

  List<SensorData> _filterRawData() {
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

    return _exponentialMovingAverage(_events);
  }

  void logFiltered(List<SensorData> filteredEvents) {
    log.log('Filtered By Exponential Moving Average factor: 0.05');
    for (var i = 0; i < _events.length; i++) {
      log.log(
          '${filteredEvents[i].timestamp - filteredEvents.first.timestamp}\t${filteredEvents[i].zAxis}');
    }
  }

  void logRaw() {
    log.log('Raw data from accelerator');
    for (var i = 0; i < _events.length; i++) {
      log.log(
          '${_events[i].timestamp - _events.first.timestamp}\t${_events[i].zAxis}');
    }
  }

  void changeAccelerometerStreamState() =>
      _accelerometerSensor.isAccelerometerSensorWorking()
          ? _accelerometerSensor.pauseAccelerometerSensorStream()
          : _accelerometerSensor.resumeAccelerometerSensorStream();

  void changeGyroscopeStreamState() =>
      _gyroscopeSensor.isGyroscopeSensorWorking()
          ? _gyroscopeSensor.pauseGyroscopeSensorStream()
          : _gyroscopeSensor.resumeGyroscopeSensorStream();

  SessionResult calculateSessionResult({List<SensorData>? filteredData}) {
    final List<List<SensorData>> refractions =
        _getRefractions(filteredData ?? _filterRawData());
    final List<SensorData> refractionPicks = _getRefractionPicks(refractions);

    final double averageCompressionsRate =
        _calculateAverageCompressionsRate(refractionPicks);
    final List<double> temporaryCompressionsRate =
        _calculateTemporaryCompressionRate(refractionPicks);

    return SessionResult(
      sessionDate: DateTime.now(),
      numberOfChestCompressions: refractions.length,
      averageCompressionsRate: averageCompressionsRate,
      temporaryCompressionRate: temporaryCompressionsRate,
    );
  }

  List<List<SensorData>> _getRefractions(List<SensorData> filteredData) {
    List<List<SensorData>> refractions = [];
    int startIndex = 0;
    int endIndex = 0;
    double currentBreakPoint = filteredData.first.zAxis;

    for (var i = 0; i < filteredData.length; i++) {
      if (currentBreakPoint.sign != filteredData[i].zAxis.sign) {
        currentBreakPoint = filteredData[i].zAxis;
        endIndex = i;
        if (currentBreakPoint.sign > 0) {
          refractions.add(filteredData.sublist(startIndex, endIndex));
        }
        startIndex = i;
      }
    }

    return refractions;
  }

  List<SensorData> _getRefractionPicks(List<List<SensorData>> refractions) =>
      refractions
          .map((refraction) => refraction.reduce(
                (currentRefraction, nextRefraction) =>
                    currentRefraction.zAxis > nextRefraction.zAxis
                        ? currentRefraction
                        : nextRefraction,
              ))
          .toList();

  double _calculateAverageCompressionsRate(List<SensorData> refractionPicks) =>
      refractionPicks.isEmpty
          ? 1
          : refractionPicks.length /
              (refractionPicks.last.timestamp -
                  refractionPicks.first.timestamp) *
              microsecondsToMinutes;

  List<double> _calculateTemporaryCompressionRate(
      List<SensorData> refractionPicks) {
    int lastCompressionTimestamp = 0;
    List<double> temporaryCompressionsRate =
        refractionPicks.mapIndexed((index, compression) {
      if (index % 10 == 0 && index != 0) {
        double currentRate = 10 /
            (compression.timestamp - lastCompressionTimestamp) *
            microsecondsToMinutes;
        lastCompressionTimestamp = compression.timestamp;
        return currentRate;
      }
      return -1.0;
    }).toList();
    temporaryCompressionsRate.removeWhere((e) => e == -1.0);
    return temporaryCompressionsRate;
  }

  void logSessionResult(SessionResult sessionResult) {
    log.log('Number of chest compressions: ' +
        sessionResult.numberOfChestCompressions.toString());
    log.log('Average compressions rate per minute: ' +
        sessionResult.averageCompressionsRate.toStringAsFixed(2));
    log.log(
        'Temporary compression rates per minute (calculated after each 10 compression): ');
    for (var rate in sessionResult.temporaryCompressionRate) {
      log.log(rate.toStringAsFixed(2));
    }
  }
}
