import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/create_custom_service_model.dart';
import 'package:handy_home_app/data/repository/home/home_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/category_model.dart';
import '../../data/models/order_service_model.dart';
import '../../data/models/service_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository = HomeRepository();

  HomeCubit() : super(HomeInitial());

  categories() async {
    emit(CategoryLoadingState());

    final data = await homeRepository.getCategory();
    data.fold((l) {
      List<CategoryModel> categories = l.data as List<CategoryModel>;
      emit(CategorySuccessState(categories: categories));
    }, (r) => emit(CategoryFailedState(message: r.message)));
  }

  categoryServices({required int id}) async {
    emit(CategoryServicesLoadingState());

    final data = await homeRepository.getServicesForCategory(id: id);
    data.fold((l) {
      emit(CategoryServicesSuccessState(
          categoryServices: l.data as CategoryWithServicesModel));
    }, (r) => emit(CategoryServicesFailedState(message: r.message)));
  }

  serviceDetails({required String endPoint}) async {
    emit(ServiceDetailsLoadingState());

    final data =
        await homeRepository.getServiceDetails(serviceEndPoint: endPoint);
    data.fold((l) {
      emit(ServiceDetailsSuccessState(serviceDetails: l.data as ServiceModel));
    }, (r) => emit(ServiceDetailsFailedState(message: r.message)));
  }

  addReview({
    required int reviewValue,
    required String comment,
    required int service,
  }) async {
    emit(ReviewLoadingState());

    final data = await homeRepository.addReview(
      reviewValue: reviewValue,
      comment: comment,
      service: service,
    );
    data.fold((l) {
      emit(ReviewSuccessState(message: l.data as String));
    }, (r) => emit(ReviewFailedState(message: r.message)));
  }

  orderFixedService(
      {required int quantity,
      required int totalPrice,
      required String date,
      required String time,
      required int location,
      required int service}) async {
    emit(OrderFixedServiceLoadingState());

    final data = await homeRepository.orderFixedService(
        location: location,
        quantity: quantity,
        totalPrice: totalPrice,
        date: date,
        time: time,
        service: service);
    data.fold((l) {
      emit(OrderFixedServiceSuccessState(
          orderedService: l.data as OrderedServiceModel));
    }, (r) => emit(OrderFixedServiceFailedState(message: r.message)));
  }

  orderCustomService({
    required String name,
    required String description,
    required String date,
    required String time,
    required int category,
    required int location,
  }) async {
    emit(OrderCustomServiceLoadingState());

    final data = await homeRepository.orderCustomService(
        name: name,
        description: description,
        date: date,
        time: time,
        category: category,
        location: location);
    data.fold((l) {
      emit(OrderCustomServiceSuccessState(
          customServiceModel: l.data as CustomServiceModel));
    }, (r) => emit(OrderCustomServiceFailedState(message: r.message)));
  }
}

class LatestServiceCubit extends Cubit<LatestServiceAddedInitialState> {
  HomeRepository homeRepository = HomeRepository();

  LatestServiceCubit() : super(LatestServiceAddedInitialState());
  latestAddedService() async {
    emit(LatestServiceAddedLoadingState());

    final data = await homeRepository.getLatestAddedServices();
    data.fold(
        (l) => emit(LatestServiceAddedSuccessState(
            services: l.data as List<ServiceModel>)),
        (r) => emit(LatestServiceAddedFailedState(message: r.message)));
  }
}
