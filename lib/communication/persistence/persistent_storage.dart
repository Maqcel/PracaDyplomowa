abstract class PersistentStorage {
  Future<bool?> getCprStatus();

  Future<void> setCprStatusAsShown();

  Future<void> clearCprStatus();
}
