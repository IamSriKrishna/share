import 'dart:convert';
import 'package:crud/core/uri/uri.dart';
import 'package:crud/core/util/net.dart';
import 'package:crud/model/user.dart';
import 'package:crud/storage/app_database.dart';
import 'package:dio/dio.dart';
import 'package:sembast/sembast.dart';
class UserRepository {
  UserModel _userModel = UserModel();
  final Dio _dio = Dio();
  final store = intMapStoreFactory.store('user_store');
  final SembastDatabase sembastDatabase = SembastDatabase();
  final ConnectivityService _connectivityService = ConnectivityService();
  final offlineStore = intMapStoreFactory.store('offline_store');

  Future<bool> createUserData(String name) async {
    final Map<String, dynamic> map = {
      "name": name,
    };

    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        Response res = await _dio.post(Url.baseUrl,
            options: Options(headers: {
              "Content-Type": "application/json",
            }),
            data: jsonEncode(map));
        if (res.statusCode == 200) {
          // Store data offline
          final db = await sembastDatabase.database;
          await store.add(db, map);
          return true;
        } else {
          return false;
        }
      } else {
        // Store the creation request offline
        final db = await sembastDatabase.database;
        await offlineStore.add(db, map);
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> syncOfflineData() async {
    final db = await sembastDatabase.database;
    final records = await offlineStore.find(db);
    for (var record in records) {
      try {
        final map = record.value;
        Response res = await _dio.post(Url.baseUrl,
            options: Options(headers: {
              "Content-Type": "application/json",
            }),
            data: jsonEncode(map));
        if (res.statusCode == 200) {
          // Successfully sent to server, remove from offline store
          await offlineStore.record(record.key).delete(db);
          await store.add(db, map);
        }
      } catch (e) {
        // Handle error, possibly retry later
      }
    }
  }

  Future<UserModel> readUserData() async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        Response res = await _dio.get(Url.baseUrl);
        if (res.statusCode == 200) {
          _userModel = _parseJson(res.data);
          // Store data offline
          final db = await sembastDatabase.database;
          // Clear old records before adding new ones
          await store.delete(db);
          for (var data in res.data) {
            await store.add(db, data);
          }
        }
      } else {
        // Fetch data from offline storage
        final db = await sembastDatabase.database;
        final records = await store.find(db);
        if (records.isNotEmpty) {
          _userModel = UserModel.fromJson(records.map((e) => e.value).toList());
        } else {
          throw Exception('No data found');
        }
      }
    } catch (e) {
      // Fetch data from offline storage
      final db = await sembastDatabase.database;
      final records = await store.find(db);
      if (records.isNotEmpty) {
        _userModel = UserModel.fromJson(records.map((e) => e.value).toList());
      } else {
        throw Exception('No data found');
      }
    }
    return _userModel;
  }

  Future<bool> deleteUserByName(String name) async {
    try {
      final isConnected = await _connectivityService.isConnected;
      if (isConnected) {
        Response res = await _dio.delete(
          Url.baseUrl,
          data: <String, dynamic>{'name': name},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        if (res.statusCode == 200) {
          // Remove data from offline storage
          final db = await sembastDatabase.database;
          final finder = Finder(filter: Filter.equals('name', name));
          await store.delete(db, finder: finder);
          return true;
        } else {
          return false;
        }
      } else {
        // Handle offline deletion if necessary
        throw Exception('Cannot delete user while offline');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  UserModel _parseJson(dynamic e) => UserModel.fromJson(e);
}
