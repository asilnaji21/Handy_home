import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/service_model.dart';
import 'package:handy_home_app/data/network/remote/dio_helper.dart';

import '../../../app/constants_manager.dart';

import '../../network/remote/api_result_handler.dart';

class SearchRepository {
  DioHelper dioHelper = DioHelper();

  Future<Either<ApiSuccess, ApiFailure>> getAllServices(
      {String? valueSearch}) async {
    ApiResults response = await dioHelper.getData(
      endPoint: Endpoints.searchEndpoint,
      queryParameters: {"q": valueSearch},
    );

    if (response is ApiSuccess) {
      return left(
        ApiSuccess(
          response.data
              .map((e) => ServiceModel.fromJson(e))
              .toList()
              .cast<ServiceModel>(),
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
