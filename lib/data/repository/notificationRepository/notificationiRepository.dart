import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/notification_model.dart';
import 'package:handy_home_app/data/network/remote/dio_helper.dart';

import '../../../app/constants_manager.dart';
import '../../../app/locator.dart';
import '../../network/local/local_network.dart';
import '../../network/remote/api_result_handler.dart';

class NotificationRepository {
  DioHelper dioHelper = DioHelper();

  Future<Either<ApiSuccess, ApiFailure>> getReadNotification() async {
    ApiResults response = await dioHelper.getData(
        endPoint: Endpoints.readNotification,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => NotificationModel.fromJson(e))
              .toList()
              .cast<NotificationModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> getUnreadNotification() async {
    ApiResults response = await dioHelper.getData(
        endPoint: Endpoints.unreadNotification,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => NotificationModel.fromJson(e))
              .toList()
              .cast<NotificationModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> changeNotification() async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.changeNotification,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess('sucess', response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }
}
