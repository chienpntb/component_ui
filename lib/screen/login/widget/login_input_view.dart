import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/login/request/auth/auth_request.dart';
import 'package:get/get.dart';
import 'package:se_gay_components/common/sg_button.dart';
import 'package:se_gay_components/common/sg_colors.dart';
import 'package:se_gay_components/common/sg_text.dart';
import 'package:se_gay_components/common/sg_textfield.dart';

class LoginInputView extends StatefulWidget {
  final AuthRequest data;
  final Function? onLogin;
  final String? errorText;
  const LoginInputView({
    super.key,
    required this.data,
    required this.onLogin,
    this.errorText,
  });

  @override
  State<LoginInputView> createState() => _LoginInputViewState();
}

class _LoginInputViewState extends State<LoginInputView> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  late AuthRequest _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  onLogin() {
    Get.focusScope?.unfocus();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (checkLoginValidate(username, password)) {
      _data = AuthRequest(username: username, password: password);
      if (widget.onLogin != null) {
        widget.onLogin!(_data);
      }
    }
  }

  bool checkLoginValidate(String username, String password) {
    setState(() {
      // Validate username
      if (username.isEmpty) {
        _emailError = 'Vui lòng nhập email';
      } else {
        _emailError = null;
      }

      // Validate password
      if (password.isEmpty) {
        _passwordError = 'Vui lòng nhập mật khẩu';
      } else if (password.length < 6) {
        _passwordError = 'Mật khẩu phải có ít nhất 6 ký tự';
      } else {
        _passwordError = null;
      }
    });

    return _emailError == null && _passwordError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
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
              controller: _usernameController,
              // label: "Email",
              hintText: "Nhập email",
              keyboardInputType: TextInputType.emailAddress,
              borderRadius: 8,
              isTextRequire: true,
              prefixIcon: const Icon(Icons.email_outlined),
              onChanged: (value) {
                setState(() {
                  // Validate mỗi khi thay đổi
                  if (value.trim().isEmpty) {
                    _emailError = 'Vui lòng nhập email';
                  } else {
                    _emailError = null;
                  }
                });
              },
            ),
            if (_emailError != null) ...[
              const SizedBox(height: 8),
              SGText(
                text: _emailError,
                color: SGAppColors.error600,
                textAlign: TextAlign.left,
                size: 14,
              ),
            ],
            const SizedBox(height: 16),
            SGTextField(
              controller: _passwordController,
              // label: "Mật khẩu",
              hintText: "Nhập mật khẩu",
              obscureText: _obscurePassword,
              borderRadius: 8,
              isTextRequire: true,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                alignment: Alignment.center,
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              onChanged: (value) {
                setState(() {
                  // Validate mỗi khi thay đổi
                  if (value.trim().isEmpty) {
                    _passwordError = 'Vui lòng nhập mật khẩu';
                  } else if (value.trim().length < 6) {
                    _passwordError = 'Mật khẩu phải có ít nhất 6 ký tự';
                  } else {
                    _passwordError = null;
                  }
                });
              },
            ),
            if (widget.errorText != null || _passwordError != null) ...[
              const SizedBox(height: 8),
              SGText(
                text: _passwordError ?? widget.errorText,
                color: SGAppColors.error600,
                textAlign: widget.errorText != null
                    ? TextAlign.center
                    : TextAlign.left,
                size: 14,
              ),
            ],
            const SizedBox(height: 24),
            SGButton(
              text: "Đăng nhập",
              onclick: onLogin,
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
    );
  }
}
