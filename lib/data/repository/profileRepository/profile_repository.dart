import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/service_provider_model.dart';
import 'package:handy_home_app/data/models/user_info_model.dart';
import 'package:handy_home_app/data/network/remote/dio_helper.dart';

import '../../../app/constants_manager.dart';
import '../../../app/locator.dart';
import '../../network/local/local_network.dart';
import '../../network/remote/api_result_handler.dart';

class ProfileRepository {
  DioHelper dioHelper = DioHelper();

  Future<Either<ApiSuccess, ApiFailure>> becomeServiceProvider(
      {required String name,
      required String phone,
      required String location,
      required int yearExperience,
      required String summaryExperience,
      required String additional,
      required int category}) async {
    ApiResults response = await dioHelper
        .postData(endPoint: Endpoints.becomeServiceProvider, data: {
      "name": name,
      "phone_number": phone,
      "location": location,
      "year_experience": yearExperience,
      "summary_experience": summaryExperience,
      "additional": additional,
      "category": category
    }, headers: {
      "Authorization":
          "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
    });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          ServiceProviderModel.fromJson(response.data),
          response.statusCode,
        ),
      );
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message.toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> editUserInfo({
    required String firstName,
    required String lastName,
  }) async {
    ApiResults response = await dioHelper.putData(
        endPoint: Endpoints.editUserInfo,
        data: {
          "first_name": firstName,
          "last_name": lastName
        },
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          response.data["detail"],
          response.statusCode,
        ),
      );
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message.toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> getUserInfo() async {
    ApiResults response = await dioHelper.getData(
        endPoint: Endpoints.getUserInfo,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          UserInfoModel.fromJson(response.data),
          response.statusCode,
        ),
      );
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message.toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> verifyPassword({
    required String password,
  }) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.verifyPassword, data: {
      "password": password,
    }, headers: {
      "Authorization":
          "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
    });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          response.data["detail"],
          response.statusCode,
        ),
      );
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message["password"][0] as String));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> changeEmail({
    required String email,
  }) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.changeEmail,
        data: {
          "email": email
        },
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          response.data["detail"],
          response.statusCode,
        ),
      );
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message["email"][0] as String));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> verifyNewEmailAdded(
      {required String code}) async {
    ApiResults response = await dioHelper.postData(
        endPoint: '/api/users/verify-new-email/',
        data: {
          "code": code
        },
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess(response.data["detail"], response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message["detail"],
            statusCode: response.statusCode));
      }
      return right(response as ApiFailure);
    }
  }

  // Future<Either<ApiSuccess, ApiFailure>> verifyNewEmailCode({
  //   required String code,
  // }) async {
  //   ApiResults response = await dioHelper.postData(
  //       endPoint: Endpoints.verifyNewEmail,
  //       data: {
  //         "code": code
  //       },
  //       headers: {
  //         "Authorization":
  //             "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
  //       });
  //   if (response is ApiSuccess) {
  //     return left(
  //       ApiSuccess(
  //         response.data["detail"],
  //         response.statusCode,
  //       ),
  //     );
  //   } else {
  //     if (response is ApiFailure && response.statusCode == 400) {
  //       return right(
  //           ApiFailure(response.message["detail"] ?? 'an error happened'));
  //     }
  //     return right(response as ApiFailure);
  //   }
  // }
}
