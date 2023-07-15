import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/category_model.dart';
import 'package:handy_home_app/data/models/create_custom_service_model.dart';
import 'package:handy_home_app/data/models/service_model.dart';

import '../../../app/constants_manager.dart';
import '../../../app/locator.dart';
import '../../models/order_service_model.dart';
import '../../network/local/local_network.dart';
import '../../network/remote/api_result_handler.dart';
import '../../network/remote/dio_helper.dart';

class HomeRepository {
  DioHelper dioHelper = DioHelper();
  Future<Either<ApiSuccess, ApiFailure>> getCategory() async {
    ApiResults response = await dioHelper.getData(
      endPoint: Endpoints.categories,
    );

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => CategoryModel.fromJson(e))
              .toList()
              .cast<CategoryModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> getServicesForCategory(
      {required int id}) async {
    ApiResults response = await dioHelper.getData(
      endPoint: Endpoints.servicesForCategory(id: id),
    );

    if (response is ApiSuccess) {
      return left(ApiSuccess(CategoryWithServicesModel.fromJson(response.data),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> getServiceDetails(
      {required String serviceEndPoint}) async {
    ApiResults response = await dioHelper.getData(
      endPoint: serviceEndPoint,
    );

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          ServiceModel.fromJson(response.data), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> getLatestAddedServices() async {
    ApiResults response = await dioHelper.getData(
      endPoint: Endpoints.latestAdded,
    );

    if (response is ApiSuccess) {
      return left(ApiSuccess(
          response.data
              .map((e) => ServiceModel.fromJson(e))
              .toList()
              .cast<ServiceModel>(),
          response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure('an error occur'));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> orderFixedService(
      {required int quantity,
      required int totalPrice,
      required int location,
      required String date,
      required String time,
      required int service}) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.orderFixedService, data: {
      "order_status": "قيد المراجعة",
      "quantity": quantity,
      "total_price": totalPrice,
      "date_order": date,
      "time_order": time,
      "service": service,
      "location": location
    }, headers: {
      "Authorization":
          "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
    });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          OrderedServiceModel.fromJson(response.data),
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

  Future<Either<ApiSuccess, ApiFailure>> orderCustomService({
    required String name,
    required String description,
    required String date,
    required String time,
    required int category,
    required int location,
  }) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.orderCustomService, data: {
      "name": name,
      "descriptions": description,
      "request_date": date,
      "request_time": time,
      "category": category,
      "location": location
    }, headers: {
      "Authorization":
          "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
    });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          CustomServiceModel.fromJson(response.data),
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

  Future<Either<ApiSuccess, ApiFailure>> addReview({
    required int reviewValue,
    required String comment,
    required int service,
  }) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.addReview,
        data: {
          "review": reviewValue,
          "comment": comment,
          "service": service
        },
        headers: {
          "Authorization":
              "Bearer ${getIt<SharedPrefController>().getUser().accessToken}"
        });

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          'تم التقييم بنجاح',
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
}
