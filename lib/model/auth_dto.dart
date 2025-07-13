
import 'package:flutter_application_2/model/user/user_info_dto.dart';

class AuthDTO {
  final String accessToken;
  final UserInfoDTO user;

  AuthDTO({
    required this.accessToken,
    required this.user,
  });

  // Convert from Json to EventDTO.
  factory AuthDTO.fromJson(Map<String, dynamic> json) {
    return AuthDTO(
        accessToken: json['access_token'],
        user: UserInfoDTO.fromJson(json['user']));
  }
}
