import 'package:dio/src/response.dart';
import 'package:flutter_application_2/model/auth_dto.dart';
import 'package:flutter_application_2/model/base/account_helper.dart';
import 'package:flutter_application_2/screen/login/request/auth/auth_request.dart';
import 'package:se_gay_components/base_api/sg_api_base.dart';

class AuthRepository extends ApiBase {
  // ignore: non_constant_identifier_names
  static String URL_LOGIN = "/api/auth/login";

  Future<Response<AuthDTO>> login(AuthRequest authRequest) async {
    try {
      // Request API
      var result = await post<AuthDTO>(
        URL_LOGIN,
        queryParameters: authRequest.toJson(),
      );

      if (result.data?.accessToken != null) {
        AccountHelper.instance.setToken(result.data!.accessToken);
      }

      return result;
    } on Exception {
      rethrow;
    }
  }
}
