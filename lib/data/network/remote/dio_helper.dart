import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/customwidget/snackbar.dart';
import 'dart:io';
import '../../../../app/constants_manager.dart';
import 'api_result_handler.dart';

class DioHelper {
  late Dio dio;

  DioHelper() {
    BaseOptions baseOptions = BaseOptions(
      validateStatus: (status) {
        if (status != null && [400, 200, 201, 204].contains(status)) {
          return true;
        }
        return false;
      },
      baseUrl: Endpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 70000),
      receiveTimeout: const Duration(milliseconds: 70000),
    );

    dio = Dio(baseOptions);
    printTest('dio');
  }

  // -----------------------------Post  Data ---------------------------- //

  Future<ApiResults> postData(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      bool formData = true,
      Map<String, dynamic>? headers
      // String? token, required String url,
      }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    try {
      printResponse('body:    $data');
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('header:    ${dio.options.headers}');
      printResponse('url:    $endPoint');
      printResponse('url:    $endPoint');
      var response = await dio.post(endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      print(response.statusCode);
      // i make it in this way because the api return difference response at this status code so i need to handel the response for all cases
      if (response.statusCode == 400) {
        print(response.data);
        return ApiFailure(response.data, statusCode: 400);
      }
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("Data syntax error");
    } on DioError catch (e) {
      print(
          '************************: ${e.message} -- ${e.response?.statusCode} -- ${e.type} -- ${e.response?.data}');
      if (e.type == DioErrorType.badResponse) {
        return ApiFailure(
            e.response?.data["detail"] ?? 'incorrect login credentials');
        // return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("unable to connect to the server");
      } else if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains("SocketException")) {
          return ApiFailure('No Internet');
        }
        return ApiFailure("Unexpected error occurred");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }

  // -----------------------------Get Data ---------------------------- //
  Future<ApiResults> getData(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    try {
      var response = await dio.get(endPoint,
          queryParameters: queryParameters, options: Options(headers: headers));
      print(response.data);
      if (response.statusCode == 400) {
        return ApiFailure(response.data, statusCode: 400);
      }
      printResponse(response.statusCode.toString());
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('queryParameters:    $queryParameters');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("Data syntax error");
    } on DioError catch (e) {
      print(
          '************************: ${e.message} -- ${e.response?.statusCode} -- ${e.type} -- ${e.response?.data}');
      if (e.type == DioErrorType.badResponse) {
        return ApiFailure(
            e.response?.data["detail"] ?? 'incorrect login credentials');
        // return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("unable to connect to the server");
      } else if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains("SocketException")) {
          showSnackBar(NavigationManager.navigatorKey.currentContext!,
              backgroundColor: Colors.grey,
              textColor: Colors.black,
              text: 'لا يوجد انترنت تحقق من الاتصال');
          return ApiFailure('No Internet');
        }
        return ApiFailure("Unexpected error occurred");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }

  // -----------------------------put  Data ---------------------------- //

  Future<ApiResults> putData(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      bool formData = true,
      Map<String, dynamic>? headers
      // String? token, required String url,
      }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    try {
      printResponse('body:    $data');
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('header:    ${dio.options.headers}');
      printResponse('url:    $endPoint');
      printResponse('url:    $endPoint');
      var response = await dio.put(endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      print(response.statusCode);
      // i make it in this way because the api return difference response at this status code so i need to handel the response for all cases
      if (response.statusCode == 400) {
        return ApiFailure(response.data, statusCode: 400);
      }
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("Data syntax error");
    } on DioError catch (e) {
      print(
          '************************: ${e.message} -- ${e.response?.statusCode} -- ${e.type} -- ${e.response?.data}');
      if (e.type == DioErrorType.badResponse) {
        return ApiFailure(
            e.response?.data["detail"] ?? 'incorrect login credentials');
        // return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("unable to connect to the server");
      } else if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains("SocketException")) {
          return ApiFailure('No Internet');
        }
        return ApiFailure("Unexpected error occurred");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }

  // -----------------------------delete  Data ---------------------------- //

  Future<ApiResults> deleteData(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      bool formData = true,
      Map<String, dynamic>? headers
      // String? token, required String url,
      }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    try {
      printResponse('body:    $data');
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('header:    ${dio.options.headers}');
      printResponse('url:    $endPoint');
      printResponse('url:    $endPoint');
      var response = await dio.delete(endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      print(response.statusCode);
      // i make it in this way because the api return difference response at this status code so i need to handel the response for all cases
      if (response.statusCode == 400) {
        return ApiFailure(response.data, statusCode: 400);
      }
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("Data syntax error");
    } on DioError catch (e) {
      print(
          '************************: ${e.message} -- ${e.response?.statusCode} -- ${e.type} -- ${e.response?.data}');
      if (e.type == DioErrorType.badResponse) {
        return ApiFailure(
            e.response?.data["detail"] ?? 'incorrect login credentials');
        // return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("unable to connect to the server");
      } else if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains("SocketException")) {
          return ApiFailure('No Internet');
        }
        return ApiFailure("Unexpected error occurred");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }

  // -----------------------------patch  Data ---------------------------- //

  Future<ApiResults> patchData(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      bool formData = true,
      Map<String, dynamic>? headers
      // String? token, required String url,
      }) async {
    dio.options.headers = {
      "Accept": "application/json",
    };

    try {
      printResponse('body:    $data');
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('header:    ${dio.options.headers}');
      printResponse('url:    $endPoint');
      printResponse('url:    $endPoint');
      var response = await dio.patch(endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      print(response.statusCode);
      // i make it in this way because the api return difference response at this status code so i need to handel the response for all cases
      if (response.statusCode == 400) {
        return ApiFailure(response.data, statusCode: 400);
      }
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("No internet connection");
    } on FormatException {
      return ApiFailure("Data syntax error");
    } on DioError catch (e) {
      print(
          '************************: ${e.message} -- ${e.response?.statusCode} -- ${e.type} -- ${e.response?.data}');
      if (e.type == DioErrorType.badResponse) {
        return ApiFailure(
            e.response?.data["detail"] ?? 'incorrect login credentials');
        // return ApiFailure(e.message);
      } else if (e.type == DioErrorType.connectionTimeout) {
        // print('check your connection');
        return ApiFailure("Make sure you are connected to the internet");
      } else if (e.type == DioErrorType.receiveTimeout) {
        // print('unable to connect to the server');
        return ApiFailure("unable to connect to the server");
      } else if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains("SocketException")) {
          return ApiFailure('No Internet');
        }
        return ApiFailure("Unexpected error occurred");
      } else {
        return ApiFailure("An error occurred, try again");
      }
    } catch (e) {
      return ApiFailure("$e An error occurred, try again");
    }
  }
}
