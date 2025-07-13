import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/model/auth_dto.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

// Define LoginInitialState class.
class LoginInitialState extends LoginState {}

// Define LoginLoadingState class.
class LoginLoadingState extends LoginState {}

// Define LoginLoadingDismissState class.
class LoginLoadingDismissState extends LoginState {}

// Define PostLoginSuccessState class.
class PostLoginSuccessState extends LoginState {
  final AuthDTO? data;

  const PostLoginSuccessState({required this.data});

  @override
  List<Object> get props => [data!];
}

// Define PostLoginFailedState class.
class PostLoginFailedState extends LoginState {
  final String title;
  final String message;
  final int code;

  const PostLoginFailedState({required this.title, required this.message, required this.code});

  @override
  List<Object> get props => [title, message, code];

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'title': title,
      'message': message,
    };
  }
}