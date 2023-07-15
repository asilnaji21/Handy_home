part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//this states for category

class CategoryLoadingState extends HomeState {}

class CategorySuccessState extends HomeState {
  final List<CategoryModel> categories;
  CategorySuccessState({required this.categories});
}

class CategoryFailedState extends HomeState {
  final String message;
  CategoryFailedState({required this.message});
}

//this states for "services for specific category"

class CategoryServicesLoadingState extends HomeState {}

class CategoryServicesSuccessState extends HomeState {
  final CategoryWithServicesModel categoryServices;
  CategoryServicesSuccessState({required this.categoryServices});
}

class CategoryServicesFailedState extends HomeState {
  final String message;
  CategoryServicesFailedState({required this.message});
}

//this states for "service details"

class ServiceDetailsLoadingState extends HomeState {}

class ServiceDetailsSuccessState extends HomeState {
  final ServiceModel serviceDetails;
  ServiceDetailsSuccessState({required this.serviceDetails});
}

class ServiceDetailsFailedState extends HomeState {
  final String message;
  ServiceDetailsFailedState({required this.message});
}

//this states for add review

class ReviewLoadingState extends HomeState {}

class ReviewSuccessState extends HomeState {
  final String message;
  ReviewSuccessState({required this.message});
}

class ReviewFailedState extends HomeState {
  final String message;
  ReviewFailedState({required this.message});
}



//this states for "latest service added"

class LatestServiceAddedInitialState {}

class LatestServiceAddedLoadingState extends LatestServiceAddedInitialState {}

class LatestServiceAddedSuccessState extends LatestServiceAddedInitialState {
  final List<ServiceModel> services;
  LatestServiceAddedSuccessState({required this.services});
}

class LatestServiceAddedFailedState extends LatestServiceAddedInitialState {
  final String message;
  LatestServiceAddedFailedState({required this.message});
}

// this states for "order fixed service"

class OrderFixedServiceLoadingState extends HomeState {}

class OrderFixedServiceSuccessState extends HomeState {
  final OrderedServiceModel orderedService;
  OrderFixedServiceSuccessState({required this.orderedService});
}

class OrderFixedServiceFailedState extends HomeState {
  final String message;
  OrderFixedServiceFailedState({required this.message});
}

// this states for "order custom service"

class OrderCustomServiceLoadingState extends HomeState {}

class OrderCustomServiceSuccessState extends HomeState {
  final CustomServiceModel customServiceModel;
  OrderCustomServiceSuccessState({required this.customServiceModel});
}

class OrderCustomServiceFailedState extends HomeState {
  final String message;
  OrderCustomServiceFailedState({required this.message});
}
