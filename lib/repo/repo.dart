import 'dart:async';
import 'dart:convert';
import 'package:crud/core/uri/uri.dart';
import 'package:crud/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserRepository {
  UserModel _userModel = UserModel();
  final Dio _dio = Dio();

  Future<bool> createUserData(String name) async {
    final Map<String, dynamic> map = {
      "name": name,
    };
    try {
      Response res = await _dio.post(Url.createUser,
          options: Options(headers: {
            "Content-Type": "application/json",
          }),
          data: jsonEncode(map));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> readUserData() async {
    try {
      Response res = await _dio.get(Url.getUser,
          options: Options(
            headers: {
              "Access-Control-Allow-Origin":
                  "*", // Required for CORS support to work
              "Access-Control-Allow-Credentials":
                  true, // Required for cookies, authorization headers with HTTPS
              "Access-Control-Allow-Headers":
                  "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
              "Access-Control-Allow-Methods": "POST, OPTIONS"
            },
          ));
      if (res.statusCode == 200) {
        _userModel = _parseJson(res.data);
      }
    } catch (e) {
      throw Exception(e);
    }
    return _userModel;
  }

  Future<bool> deleteUserByName(String name) async {
    try {
      Response res = await _dio.delete(
        Url.deleteUser,
        data: <String, dynamic>{'name': name},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      debugPrint(res.data.toString());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  UserModel _parseJson(dynamic e) => UserModel.fromJson(e);
}
