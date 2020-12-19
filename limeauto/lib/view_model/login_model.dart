

import 'package:flutter/foundation.dart';
import 'package:limeauto/config/storage_manager.dart';
import 'package:limeauto/model/user.dart';
import 'package:limeauto/provider/view_state_model.dart';
import 'package:limeauto/service/limeauto_repository.dart';

import 'user_model.dart';

const String kLoginName = 'kLoginName';

class LoginModel extends ViewStateModel {
  UserModel userModel = UserModel();
  User user;

  String getLoginName() {
    return StorageManager.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(loginName, password) async {
    setBusy();
    try {
      LoginRes loginRes = await LimeAutoRepository.login(loginName, password);
      StorageManager.sharedPreferences
          .setString("accessToken", loginRes.access_token);
      user = await LimeAutoRepository.profile();
      debugPrint(user.toString());
      debugPrint(userModel.toString());
      userModel.saveUser(user);
      StorageManager.sharedPreferences
          .setString(kLoginName, userModel.user.userName);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async {}

}

