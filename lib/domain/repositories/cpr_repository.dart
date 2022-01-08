import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praca_inz/communication/network/dto/session/sensor_data_dto.dart';
import 'package:praca_inz/communication/network/dto/session/session_result_dto.dart';
import 'package:praca_inz/communication/persistence/persistent_storage.dart';
import 'package:praca_inz/config/paths.dart';
import 'package:praca_inz/domain/models/session_result.dart';

class CprRepository {
  final PersistentStorage _persistentStorage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CprRepository({required PersistentStorage persistentStorage})
      : _persistentStorage = persistentStorage;

  Future<bool> shouldShowCprInstruction() async =>
      await _persistentStorage.getCprStatus() ?? true;

  void cprInstructionClosed() => _persistentStorage.setCprStatusAsShown();

  Future<void> addSessionToFirestore(
    SessionResult result,
    String userUid,
  ) =>
      _firestore
          .collection(Paths.sessions)
          .add(
            SessionResultDTO(
              sessionDate: result.sessionDate,
              numberOfChestCompressions: result.numberOfChestCompressions,
              averageCompressionsRate: result.averageCompressionsRate,
              temporaryCompressionRate: result.temporaryCompressionRate,
              rawData: result.rawData
                  .map(
                    (sensorDataTimestamp) => SensorDataDTO(
                      timestamp: sensorDataTimestamp.timestamp,
                      zAxis: sensorDataTimestamp.zAxis,
                    ).toJson(),
                  )
                  .toList(),
            ).toJson(),
          )
          .then((value) {
        log(result.rawData.length.toString());
        _firestore.collection(Paths.usersPath).doc(userUid).update({
          'completedSessions': FieldValue.arrayUnion([value])
        });
      });
}
