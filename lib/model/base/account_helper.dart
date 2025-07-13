
import 'package:flutter_application_2/model/base/storage_service.dart';
import 'package:flutter_application_2/model/user/user_info_dto.dart';

class AccountHelper {
  //create private constructor
  const AccountHelper._privateConstructor();

  //create instance
  static const AccountHelper _instance = AccountHelper._privateConstructor();

  static AccountHelper get instance => _instance;

  setUserInfo(userLogin) {
    StorageService.write(StorageKey.USER_INFO, userLogin);
  }

  UserInfoDTO? getUserInfo() {
    if (StorageService.read(StorageKey.USER_INFO) != null) {
      return StorageService.read(StorageKey.USER_INFO);
    }
    return null;
  }

  int getUserId() {
    UserInfoDTO? user = StorageService.read(StorageKey.USER_INFO);
    if (user != null) {
      return user.id;
    }
    return -1;
  }

  setToken(String token) {
    StorageService.write(StorageKey.TOKEN, token);
  }

  String? getToken() {
    return StorageService.read(StorageKey.TOKEN);
  }

  setRememberLogin(bool status) {
    StorageService.write(StorageKey.REMEMBER_LOGIN, status);
  }

  bool? getRememberLogin() {
    return StorageService.read(StorageKey.REMEMBER_LOGIN);
  }
}
