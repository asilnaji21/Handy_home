import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../presentation/resources/color_manager.dart';

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

  //home service screen
  static const String categories = '/api/services/categories/';
  static String servicesForCategory({required int id}) {
    return '/api/services/category/$id/services/';
  }

  static String serviceDetails({required int id}) {
    return '$baseUrl/api/services/$id/detail/';
  }

  static const String latestAdded = '/api/services/latest-add/';
  static const String orderFixedService = '/api/orders/';
  static const String orderCustomService = '/api/users/create-custom-service/';
  static const String addReview = '/api/reviews/';

// booked service endpoint
  static const String allOrder = '/api/orders/all-order/';
  static const String activeOrder = '/api/orders/active-order/';

//profile endpoint
  static const String becomeServiceProvider =
      '/api/users/create-service-provider/';
  static const String editUserInfo = '/api/users/edit-user/';
  static const String getUserInfo = '/api/users/user-data/';
  static const String verifyPassword = '/api/users/verify-password/';
  static const String changeEmail = '/api/users/change-email/';
  static const String verifyNewEmail = '/api/users/verify-new-email/';
  static const String getLocation = '/api/users/location/';
  static const String addLocation = '/api/users/location/';

  // search endpoint
  static const String searchEndpoint = '/api/services/';
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

Color checkColor({required String status, required bool isForText}) {
  if (status == 'مرفوض') {
    return isForText ? ColorManager.redDarkColor : ColorManager.redLightColor;
  } else if (status == 'مكتمل') {
    return isForText
        ? ColorManager.greenDarkColor
        : ColorManager.greenLightColor;
  } else if (status == 'قيد المراجعة') {
    return isForText
        ? ColorManager.orangeDarkColor
        : ColorManager.orangeLightColor;
  } else {
    return isForText ? ColorManager.blueDarkColor : ColorManager.blueLightColor;
  }
}
