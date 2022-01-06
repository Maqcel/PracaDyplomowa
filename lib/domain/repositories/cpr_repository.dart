import 'package:praca_inz/communication/persistence/persistent_storage.dart';

class CprRepository {
  final PersistentStorage _persistentStorage;

  CprRepository({required PersistentStorage persistentStorage})
      : _persistentStorage = persistentStorage;

  Future<bool> shouldShowCprInstruction() async =>
      await _persistentStorage.getCprStatus() ?? true;

  void cprInstructionClosed() => _persistentStorage.setCprStatusAsShown();
}
