import 'package:flutter/foundation.dart';

class Constant {
  static const String baseUrl = 'http://demo-api.mr-dev.tech/api';
}

class Endpoints {
  static const String baseUrl =
      'https://mohammedashrafdagga.pythonanywhere.com';

  // auth endpoint
  static const String login = '/api/auth/login/';

  static const String register = '/api/auth/register/';
  static const String verifyCode = '/api/auth/verify-code/';
  static const String sendCodeToResetPassword =
      '/api/auth/reset-password-code/';

  static const String verifyResetPasswordCode =
      '/api/auth/verify-reset-password-code/';
  static const String resetNewPassword = '/api/auth/reset-new-password/';
  static const String resendCode = '/api/auth/resend-code/';
  static const String logout = '/api/auth/logout/';
  static const String refreshToken = '/api/auth/login-refresh/';


  //home service screen
  static const String categories = '/api/services/categories/';
  static String servicesForCategory({required int id}) {
    return '/api/services/category/$id/services/';
  }

  static String serviceDetails({required int id}) {
    return '/api/services/$id/detail/';
  }

  static const String latestAdded = '/api/services/latest-add/';
  static const String orderFixedService = '/api/orders/';
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
