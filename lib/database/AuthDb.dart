import 'package:sembast/sembast.dart';
import 'package:laundry/database/DbHealper.dart';

class AuthDb {
  final _authStore = StoreRef.main();

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future store(String key, dynamic data) async {
    await _authStore.record(key).put(await _db, data);
  }

  Future fetch(String key) async {
    await _authStore.record(key).get(await _db);
  }

  Future delete(String key) async {
    await _authStore.record(key).delete(await _db);
  }
}