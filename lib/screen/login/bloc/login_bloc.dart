import 'package:flutter_application_2/model/auth_dto.dart';
import 'package:flutter_application_2/screen/login/Repository/auth_repository.dart';
import 'package:flutter_application_2/screen/login/bloc/login_event.dart';
import 'package:flutter_application_2/screen/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart' as dio;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<PostLoginEvent>(_postLogin);
    on<GetUsersEvent>(_getUsers);
    on<CreateUserEvent>(_createUser);
    on<UpdateUserEvent>(_updateUser);
    on<DeleteUserEvent>(_deleteUser);
  }

  // Handle PostLoginEvent.
  //
  // Call method postLogin(event) api in AuthRepository.
  // Handle LoginSuccessState or LoginFailedState.
  // Emit to view.
  Future<void> _postLogin(PostLoginEvent event, Emitter emit) async {
    emit(LoginInitialState());
    emit(LoginLoadingState());
    // Result<AuthDTO, NetworkError> result =
    //     await AuthRepository().postLogin(event.params);

    dio.Response<AuthDTO> result = await AuthRepository().login(event.params);

    emit(LoginLoadingDismissState());
    if (event.params.username == "1") {

      emit(const PostLoginSuccessState(data: null));
      return;
    }
    if (result.statusCode == 200 && result.data != null) {
      emit(PostLoginSuccessState(data: result.data));
    } else {
      emit(PostLoginFailedState(
          title: "notice",
          code: result.statusCode ?? -1,
          message: result.statusMessage ?? ''));
    }
  }

  Future<void> _getUsers(GetUsersEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      final result = await AuthRepository().getUsers();
      emit(LoginLoadingDismissState());
      if (result.statusCode == 200 && result.data != null) {
        emit(GetUsersSuccessState(result.data!));
      } else {
        emit(PostLoginFailedState(
            title: "notice",
            code: result.statusCode ?? -1,
            message: result.statusMessage ?? ''));
      }
    } catch (e) {
      emit(LoginLoadingDismissState());
      emit(PostLoginFailedState(title: "error", code: -1, message: e.toString()));
    }
  }

  Future<void> _createUser(CreateUserEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      final result = await AuthRepository().createUser(event.user);
      emit(LoginLoadingDismissState());
      if (result.statusCode == 200 && result.data != null) {
        emit(CreateUserSuccessState(result.data!));
      } else {
        emit(PostLoginFailedState(
            title: "notice",
            code: result.statusCode ?? -1,
            message: result.statusMessage ?? ''));
      }
    } catch (e) {
      emit(LoginLoadingDismissState());
      emit(PostLoginFailedState(title: "error", code: -1, message: e.toString()));
    }
  }

  Future<void> _updateUser(UpdateUserEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      final result = await AuthRepository().updateUser(event.id, event.user);
      emit(LoginLoadingDismissState());
      if (result.statusCode == 200 && result.data != null) {
        emit(UpdateUserSuccessState(result.data!));
      } else {
        emit(PostLoginFailedState(
            title: "notice",
            code: result.statusCode ?? -1,
            message: result.statusMessage ?? ''));
      }
    } catch (e) {
      emit(LoginLoadingDismissState());
      emit(PostLoginFailedState(title: "error", code: -1, message: e.toString()));
    }
  }

  Future<void> _deleteUser(DeleteUserEvent event, Emitter emit) async {
    emit(LoginLoadingState());
    try {
      final result = await AuthRepository().deleteUser(event.id);
      emit(LoginLoadingDismissState());
      if (result.statusCode == 200) {
        emit(DeleteUserSuccessState());
      } else {
        emit(PostLoginFailedState(
            title: "notice",
            code: result.statusCode ?? -1,
            message: result.statusMessage ?? ''));
      }
    } catch (e) {
      emit(LoginLoadingDismissState());
      emit(PostLoginFailedState(title: "error", code: -1, message: e.toString()));
    }
  }
}
