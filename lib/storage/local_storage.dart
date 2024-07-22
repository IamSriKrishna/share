import 'package:crud/model/user.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  Database? _db;
  late final StoreRef<int, Map<String, dynamic>> _store;

  Future<void> init() async {
    _db = await databaseFactoryIo.openDatabase('users.db');
    _store = intMapStoreFactory.store('users');
  }

  Future<void> addUser(UserModel user) async {
    await _store.add(_db!, user.toJson());
  }

  // Future<void> deleteUser(String name) async {
  //   final finder = Finder(filter: Filter.equals('name', name));
  //   final records = await _store.find(_db!, finder: finder);
  //   for (var record in records) {
  //     await _store.delete(_db!, key: record.key);
  //   }
  // }

  Future<List<UserModel>> getUsers() async {
    final snapshots = await _store.find(_db!);
    return snapshots.map((snapshot) => UserModel.fromJson(snapshot.value)).toList();
  }
}
