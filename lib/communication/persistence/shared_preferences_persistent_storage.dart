import 'package:praca_inz/communication/persistence/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPersistentStorage extends PersistentStorage {
  static const String keyCprStatus = "CPR_STATUS";

  @override
  Future<void> clearCprStatus() async =>
      SharedPreferences.getInstance().then((prefs) {
        prefs.clear();
      });

  @override
  Future<bool?> getCprStatus() async =>
      (await SharedPreferences.getInstance()).getBool(keyCprStatus);

  @override
  Future<void> setCprStatusAsShown() =>
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool(keyCprStatus, false);
      });
}
