import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

enum PrefKeys {
  user,
  isLoggedIn,
}

class SharedPrefController {
  static final _instance = SharedPrefController._();

  factory SharedPrefController() {
    return _instance;
  }

  late SharedPreferences preferences;
  SharedPrefController._();

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  save(UserModel user) async {
    String userEncoded = jsonEncode(user.toJson());
    await preferences.setString(
      PrefKeys.user.toString(),
      userEncoded,
    );
  }

  UserModel getUser() {
    String userJson = preferences.getString(PrefKeys.user.toString()) ?? '';
    final userObject = jsonDecode(userJson);
    return UserModel.fromJson(userObject);
  }

  isLoggedIn({required bool value}) {
    preferences.setBool(PrefKeys.isLoggedIn.toString(), value);
  }

  bool getLoggedIn() {
    return preferences.getBool(PrefKeys.isLoggedIn.toString()) ?? false;
  }

  clear() {
    preferences.clear();
  }
}
