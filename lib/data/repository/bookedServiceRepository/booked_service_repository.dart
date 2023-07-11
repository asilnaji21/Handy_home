import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/order_service_model.dart';

import '../../../app/constants_manager.dart';
import '../../../app/locator.dart';
import '../../network/local/local_network.dart';
import '../../network/remote/api_result_handler.dart';
import '../../network/remote/dio_helper.dart';

class BookedServiceRepository {
  DioHelper dioHelper = DioHelper();

  Future<Either<ApiSuccess, ApiFailure>> allOrders() async {
    ApiResults response = await dioHelper.getData(
        endPoint: Endpoints.allOrder,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => OrderedServiceModel.fromJson(e))
              .toList()
              .cast<OrderedServiceModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

   Future<Either<ApiSuccess, ApiFailure>> activeOrder() async {
    ApiResults response = await dioHelper.getData(
        endPoint: Endpoints.activeOrder,
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => OrderedServiceModel.fromJson(e))
              .toList()
              .cast<OrderedServiceModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }
}
