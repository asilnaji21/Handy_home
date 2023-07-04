import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/category_model.dart';

import '../../../app/constants_manager.dart';
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
}
