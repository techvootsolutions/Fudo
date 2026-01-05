import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/sharedpref/shared_pref.dart';
import 'package:fudo/src/core/utils/singleton/singleton.dart';
import 'package:fudo/src/features/auth/domain/repositories/auth_repositories.dart';

class RegistrationProvider with ChangeNotifier {
  AuthRepository authRepository;
  RegistrationProvider(this.authRepository);
  // 1. Private State
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  bool _isLoading = false;

  // 2. Getters
  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  bool get isLoading => _isLoading;

  // 3. Setters with immediate error clearing for better UX
  void setName(String value) {
    _name = value.trim();
    if (_nameError != null) {
      _nameError = null;
      notifyListeners();
    }
  }

  void setEmail(String value) {
    _email = value.trim();
    if (_emailError != null) {
      _emailError = null;
      notifyListeners();
    }
  }

  void setPassword(String value) {
    _password = value;
    if (_passwordError != null) {
      _passwordError = null;
      notifyListeners();
    }
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    if (_confirmPasswordError != null) {
      _confirmPasswordError = null;
      notifyListeners();
    }
  }

  // 4. Optimized Validation Logic
  bool _validate() {
    bool isValid = true;

    // Name Validation
    if (_name.isEmpty) {
      _nameError = "Name is required";
      isValid = false;
    }

    // Email Validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_email.isEmpty) {
      _emailError = "Email is required";
      isValid = false;
    } else if (!emailRegex.hasMatch(_email)) {
      _emailError = "Enter a valid email address";
      isValid = false;
    }

    // Password Validation
    if (_password.isEmpty) {
      _passwordError = "Password is required";
      isValid = false;
    } else if (_password.length < 8) {
      _passwordError = "Password must be at least 8 characters";
      isValid = false;
    }

    // Confirm Password Validation
    if (_confirmPassword != _password) {
      _confirmPasswordError = "Passwords do not match";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  // 5. Registration Action
  register() async {
    if (!_validate()) return false;

    _isLoading = true;
    notifyListeners();
    final prams = {
      "name": _name,
      "email": _email,
      "password": _password,
      "password_confirmation": _confirmPassword,
    };
    try {
      await authRepository
          .registerUser(argument: jsonEncode(prams))
          .then(
            (value) => value.handleResponse(
              onSuccess: (data)async {
                _isLoading = false;
                notifyListeners();
                 await SharedPref.instance.saveUserData(data);
                Singleton.instance.authToken = data.data?.token;
                NavigationService.pushNamedAndRemoveUntil(AppRoutes.fitnessPlanScreen);
              },
              onFailure: (errorMessage) {
                _isLoading = false;
                errorDialog(
                  errorMessage,
                  NavigationService.navigatorKey.currentContext!,
                );
                notifyListeners();
              },
            ),
          );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
