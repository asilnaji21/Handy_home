import 'package:flutter/foundation.dart';

class Constant {
  static const String baseUrl = 'http://demo-api.mr-dev.tech/api';
}

class Endpoints {
  static const String baseUrl =
      'https://mohammedashrafdagga.pythonanywhere.com';
  static const String login = '/api/auth/login/';

  static const String register = '/api/auth/register/';
  static const String verifyCode = '/api/auth/verify-code/';
  static const String sendCodeToResetPassword =
      '/api/auth/reset-password-code/';

  static const String verifyResetPasswordCode =
      '/api/auth/verify-reset-password-code/';
  static const String resetNewPassword=
      '/api/auth/reset-new-password/';
      
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}
