import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/login/bloc/login_bloc.dart';
import 'package:flutter_application_2/screen/login/bloc/login_state.dart';
import 'package:flutter_application_2/screen/login/provider/login_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:se_gay_components/common/sg_textfield.dart';
import 'package:se_gay_components/common/sg_button.dart';
import 'package:se_gay_components/common/sg_text.dart';
import 'package:se_gay_components/common/sg_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(context),
      child: BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginInitialState) {}
            if (state is LoginLoadingState) {
              // AppUtility.showLoadingDialog();
            }
            if (state is LoginLoadingDismissState) {
              // AppUtility.closeDialog();
            }
            if (state is PostLoginSuccessState) {
              context.read<LoginProvider>().onLoginSuccess(context, state);
            }
            if (state is PostLoginFailedState) {
              context.read<LoginProvider>().onLoginFailed(state);
            }
          },
          builder: (BuildContext context, LoginState state) {
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
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SGText(
                          text: "Đăng nhập",
                          size: 28,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SGTextField(
                          controller: _emailController,
                          label: "Email",
                          hintText: "Nhập email",
                          keyboardInputType: TextInputType.emailAddress,
                          borderRadius: 8,
                          isTextRequire: true,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: 16),
                        SGTextField(
                          controller: _passwordController,
                          label: "Mật khẩu",
                          hintText: "Nhập mật khẩu",
                          obscureText: _obscurePassword,
                          borderRadius: 8,
                          isTextRequire: true,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        if (_errorText != null) ...[
                          const SizedBox(height: 8),
                          SGText(
                            text: _errorText,
                            color: SGAppColors.error600,
                            textAlign: TextAlign.center,
                            size: 14,
                          ),
                        ],
                        const SizedBox(height: 24),
                        SGButton(
                          text: "Đăng nhập",
                          onclick: () {
                            setState(() {
                              _errorText = null;
                            });
                          },
                          borderRadius: 8,
                          height: 48,
                          textSize: 16,
                          fontWeight: FontWeight.bold,
                          activeColor: SGAppColors.primary600,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {},
                          child: const SGText(
                            text: "Quên mật khẩu?",
                            color: SGAppColors.primary600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
