
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/screen/login/bloc/login_bloc.dart';
import 'package:flutter_application_2/screen/login/bloc/login_event.dart';
import 'package:flutter_application_2/screen/login/bloc/login_state.dart';
import 'package:flutter_application_2/screen/login/request/auth/auth_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginProvider with ChangeNotifier {
  get authRequest => _authRequest;
  get error => _error;

  AuthRequest _authRequest = AuthRequest(username: "", password: "");
  String? _error;

  LoginProvider(BuildContext context) {
    onInit(context);
  }

  // onInit method
  onInit(BuildContext context) {
    // AppLog.d("onInit LoginProvider");
  }

  // onDispose method
  onDispose() {}

  // onPressLogin method
  onPressLogin(BuildContext context, AuthRequest data) {
    Get.focusScope?.unfocus();
    _authRequest = data;
    if (context.mounted) {
      context.read<LoginBloc>().add(PostLoginEvent(_authRequest));
    }
    notifyListeners();
  }

  // onLoginSuccess method
  onLoginSuccess(BuildContext context, PostLoginSuccessState data) async {
    _error = null;
    notifyListeners();
    // AppR.instance.navigateAndRemove(
    //   navigatorKey: AppRoutes.instance.navigatorKey,
    //   routeName: Routes.APP_NAVIGATOR,
    // );
  }

  // onLoginFailed method
  onLoginFailed(PostLoginFailedState state) {
    _error = "Incorrect username or password";
    notifyListeners();
  }
}
