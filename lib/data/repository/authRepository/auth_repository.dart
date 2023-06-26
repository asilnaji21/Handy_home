import 'package:handy_home_app/app/constants_manager.dart';
import 'package:handy_home_app/data/network/remote/dio_helper.dart';

import '../../network/remote/api_result_handler.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  DioHelper dioHelper = DioHelper();
  Future<Either<ApiSuccess, ApiFailure>> userRegister(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.register, data: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password
    });

    if (response is ApiSuccess) {
      return left(ApiSuccess(response.data["detail"], response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        right(ApiFailure(response.message['detail'][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> verifyCode(
      {required String code}) async {
    ApiResults response = await dioHelper
        .postData(endPoint: Endpoints.verifyCode, data: {"code": code});
    if (response is ApiSuccess) {
      return left(
          ApiSuccess(response.data["detail"].toString(), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message['code'][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }
}
