import 'package:dartz/dartz.dart';
import 'package:handy_home_app/data/models/service_provider_model.dart';
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
}
