import 'package:sembast/sembast.dart';
import 'package:laundry/database/DbHealper.dart';
import 'package:laundry/models/Auth.dart';

class AuthDb {

  static const String USERS_STORE_NAME = 'auth';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are User objects converted to Map
  final _userStore = intMapStoreFactory.store(USERS_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Auth user) async {
    await _userStore.add(await _db, user.toMap());
  }

  Future update(Auth user) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(user.uid));
    await _userStore.update(
      await _db,
      user.toMap(),
      finder: finder,
    );
  }

  Future delete(Auth user) async {
    final finder = Finder(filter: Filter.byKey(user.uid));
    await _userStore.delete(
      await _db,
      finder: finder,
    );
  }
}