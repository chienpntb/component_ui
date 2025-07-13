import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/screen/login/request/auth/auth_request.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PostLoginEvent extends LoginEvent {
  final AuthRequest params;

  const PostLoginEvent(this.params);

  @override
  List<Object?> get props => [params];
}