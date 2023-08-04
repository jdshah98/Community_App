import 'dart:convert';

import 'package:community_app/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String loggedInPref = "LOGGED_IN_STATUS";
  static const String loggedInUserPref = "LOGGED_IN_USER_DATA";
  static const String loggedInContact = "LOGGED_IN_CONTACT";
  static const String localPath = "LOCAL_PATH";
  static const String cachedCommittee = "CACHED_COMMITTEE";

  static Future setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loggedInPref, true);
  }

  static Future<bool> getLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInPref) ?? false;
  }

  static Future setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> isCacheAvailable(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future setCacheAvailable(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future setLoggedUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(loggedInUserPref, jsonEncode(user.toMap()));
  }

  static Future<Map> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(loggedInUserPref) ?? "") ?? {};
  }

  static Future clearSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
