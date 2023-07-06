import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:permission_handler_demo/pages/shared_pref_demo/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref.init() {
    instance ??= SharedPref._internal();
    instance?.getSharedPref();
  }
  SharedPref._internal();

  static SharedPref? instance = SharedPref._internal();
  late final SharedPreferences sharedPref;
  Future<void> getSharedPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Future<String?> getUserName() async {
    return sharedPref.getString('userName');
  }

  Future<String?> getPassword() async {
    return sharedPref.getString('password');
  }

  Future<String?> getEmail() async {
    return sharedPref.getString('email');
  }

  Future<String?> readUserData() async {
    return sharedPref.getString('userData');
  }

  Future<List<String>?> getAllEmails() async {
    debugPrint('Total emails are ${sharedPref.getStringList('emails')}');
    return sharedPref.getStringList('emails');
  }

  Future<void> setUserData(String name, String age, String location) async {
    final user = UserModel(name: name, location: location, age: age);
    final json = jsonEncode(user);
    debugPrint('Json is $json');
    await sharedPref.setString('userData', json);
  }

  Future<void> setUserName(String userName) async {
    await sharedPref.setString('userName', userName);
  }

  Future<void> setPassword(String password) async {
    await sharedPref.setString('password', password);
  }

  Future<void> setEmail(String email) async {
    await sharedPref.setString('email', email);
  }

  Future<void> setListOfEmail(List<String> emails) async {
    debugPrint('List of Emails is $emails');
    await sharedPref.setStringList('emails', emails);
  }

  Future<void> clearSharedPref() async {
    await sharedPref.clear();
  }

  Future<List<Widget>> getAllPrefs() async {
    debugPrint('GET ALL PREFS CALLED');

    return sharedPref
        .getKeys()
        .map<Widget>(
          (key) => ListTile(
            title: Text(key),
            subtitle: Text(sharedPref.get(key).toString()),
          ),
        )
        .toList(growable: false);
  }

/*  Future<void> setData<T>(String key, T value) async {
    switch (T) {
      case String:
        await _prefs.setString(key, value as String);
        break;
      case int:
        await _prefs.setInt(key, value as int);
        break;
      case double:
        await _prefs.setDouble(key, value as double);
        break;
      case List<String>:
        await _prefs.setStringList(key, value as List<String>);
        break;
      case bool:
        await _prefs.setBool(key, value as bool);
        break;
    }
  }

  T? getData<T>(String key) {
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case List<String>:
        return _prefs.getStringList(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      default:
        return null;
    }
  }*/
}
