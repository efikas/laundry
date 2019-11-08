import 'package:sembast/sembast.dart';
import 'package:laundry/database/DbHealper.dart';

class AuthDb {
  final _authStore = StoreRef.main();

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  // static const String FRUIT_STORE_NAME = 'fruits';
  // // A Store with int keys and Map<String, dynamic> values.
  // // This Store acts like a persistent map, values of which are Fruit objects converted to Map
  // final _fruitStore = intMapStoreFactory.store(FRUIT_STORE_NAME);


  // Future insert(Fruit fruit) async {
  //   await _fruitStore.add(await _db, fruit.toMap());
  // }

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