import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_2/model/auth_dto.dart';
import 'package:flutter_application_2/base/account_helper.dart';
import 'package:flutter_application_2/model/user/user_info_dto.dart';
import 'package:flutter_application_2/screen/login/request/auth/auth_request.dart';
import 'package:se_gay_components/base_api/sg_api_base.dart';

class AuthRepository extends ApiBase {
  // ignore: non_constant_identifier_names
  static String DOMAIN = "http://103.112.211.148:1111";
  static String URL_LOGIN = "/api/auth/login";
  static String URL_LIST_USER = "/api/users";
  static String URL_DELETE_USER = "/api/users/";
  static String URL_CREATE_USER = "/api/users/";

  Future<Response<AuthDTO>> login(AuthRequest authRequest) async {
    try {
      String url = DOMAIN + URL_LOGIN;
      // Request API

      var result = await post<AuthDTO>(
        url,
        queryParameters: authRequest.toJson(),
      );

      AccountHelper.instance.setAuthInfo(result);

      if (result.data?.accessToken != null) {
        AccountHelper.instance.setToken(result.data!.accessToken);
      }

      log('message AccountHelper: ${AccountHelper.instance.getAuthInfo()}');

      return result;
    } on Exception {
      rethrow;
    }
  }

  Future<Response<UserInfoDTO>> createUser(UserInfoDTO user) async {
    try {
      String url = DOMAIN + URL_LIST_USER;
      final response = await post(
        url,
        data: user.toJson(),
      );
      final userCreated =
          UserInfoDTO.fromJson(Map<String, dynamic>.from(response.data));
      return Response<UserInfoDTO>(
        data: userCreated,
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response<UserInfoDTO>> updateUser(String id, UserInfoDTO user) async {
    try {
      String url = '$DOMAIN$URL_LIST_USER/$id';
      final response = await put(
        url,
        data: user.toJson(),
      );
      final userUpdated =
          UserInfoDTO.fromJson(Map<String, dynamic>.from(response.data));
      return Response<UserInfoDTO>(
        data: userUpdated,
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response<void>> deleteUser(String id) async {
    try {
      String url = '$DOMAIN$URL_LIST_USER/$id';
      final response = await delete(url);
      return Response<void>(
        data: null,
        statusCode: response.statusCode,
        requestOptions: response.requestOptions,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response<List<UserInfoDTO>>> getUsers() async {
    try {
      String url = DOMAIN + URL_LIST_USER;
      // final response = await get(url);
      final response = fakeUserList;
      // Giả sử API trả về List<Map>
      final List<UserInfoDTO> users = (response as List)
          .map((e) => UserInfoDTO.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      // return Response<List<UserInfoDTO>>(
      //   data: users,
      //   statusCode: response.statusCode,
      //   requestOptions: response.requestOptions,
      // );
      return Response<List<UserInfoDTO>>(
        data: users,
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      );
    } on Exception {
      rethrow;
    }
  }
}

final fakeUserList = [
  {
    "id": 1,
    "username": "admin",
    "password": "hashed_password_1",
    "fullName": "Admin User",
    "dateOfBirth": "1985-01-01T00:00:00.000Z",
    "email": "admin@example.com",
    "createdAt": "2024-01-01T08:00:00.000Z",
    "updatedAt": "2024-01-10T10:00:00.000Z",
    "createdBy": "system",
    "updatedBy": "admin",
    "isActive": true,
    "role": "ADMIN"
  },
  {
    "id": 2,
    "username": "john_doe",
    "password": "hashed_password_2",
    "fullName": "John Doe",
    "dateOfBirth": "1990-05-15T00:00:00.000Z",
    "email": "john.doe@example.com",
    "createdAt": "2024-02-01T09:00:00.000Z",
    "updatedAt": "2024-02-15T11:00:00.000Z",
    "createdBy": "admin",
    "updatedBy": "john_doe",
    "isActive": true,
    "role": "USER"
  },
  {
    "id": 3,
    "username": "jane_smith",
    "password": "hashed_password_3",
    "fullName": "Jane Smith",
    "dateOfBirth": "1992-08-20T00:00:00.000Z",
    "email": "jane.smith@example.com",
    "createdAt": "2024-03-01T10:00:00.000Z",
    "updatedAt": null,
    "createdBy": "admin",
    "updatedBy": null,
    "isActive": false,
    "role": "USER"
  }
];
