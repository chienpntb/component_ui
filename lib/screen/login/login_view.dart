import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/login/bloc/login_bloc.dart';
import 'package:flutter_application_2/screen/login/bloc/login_state.dart';
import 'package:flutter_application_2/screen/login/provider/login_provider.dart';
import 'package:flutter_application_2/screen/login/widget/login_input_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:se_gay_components/common/sg_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: ChangeNotifierProvider(
        create: (_) => LoginProvider(context),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginInitialState) {}
            if (state is LoginLoadingState) {
              // AppUtility.showLoadingDialog();
              log('message LoginLoadingState');
            }
            if (state is LoginLoadingDismissState) {
              // AppUtility.closeDialog();
              log('message LoginLoadingDismissState');
            }
            if (state is PostLoginSuccessState) {
              context.read<LoginProvider>().onLoginSuccess(context, state);
              log('message PostLoginSuccessState');
            }
            if (state is PostLoginFailedState) {
              context.read<LoginProvider>().onLoginFailed(state);
              log('message PostLoginFailedState');
            }
          },
          builder: (BuildContext context, LoginState state) {
            return Consumer<LoginProvider>(
              builder: (loginProviderContext, valueLoginProvider, child) {
                return Scaffold(
                  backgroundColor: SGAppColors.neutral100,
                  body: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: LoginInputView(
                          data: valueLoginProvider.authRequest,
                          errorText: valueLoginProvider.error,
                          onLogin: (data) {
                            valueLoginProvider.onPressLogin(context, data);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
