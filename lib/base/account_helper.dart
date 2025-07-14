import 'dart:developer';

import 'package:flutter_application_2/base/storage_service.dart';
import 'package:flutter_application_2/model/auth_dto.dart';
import 'package:flutter_application_2/model/user/user_info_dto.dart';

class AccountHelper {
  //create private constructor
  const AccountHelper._privateConstructor();

  //create instance
  static const AccountHelper _instance = AccountHelper._privateConstructor();

  static AccountHelper get instance => _instance;

  setUserInfo(userLogin) {
    log("setUserInfo $userLogin");
    StorageService.write(StorageKey.USER_INFO, userLogin);
  }

  setAuthInfo(userLogin) {
    log("setUserInfo $userLogin");
    StorageService.write(StorageKey.AUTH_INFO, userLogin);
  }

  UserInfoDTO? getUserInfo() {
    final raw = StorageService.read(StorageKey.USER_INFO);
    if (raw == null) return null;
    if (raw is UserInfoDTO) return raw;
    if (raw is Map) return UserInfoDTO.fromJson(Map<String, dynamic>.from(raw));
    return null;
  }
  AuthDTO? getAuthInfo() {
    final raw = StorageService.read(StorageKey.AUTH_INFO);
    if (raw == null) return null;
    if (raw is AuthDTO) return raw;
    if (raw is Map) return AuthDTO.fromJson(Map<String, dynamic>.from(raw));
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
