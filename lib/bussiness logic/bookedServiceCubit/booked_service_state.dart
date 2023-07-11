part of 'booked_service_cubit.dart';

@immutable
abstract class BookedServiceState {}

class BookedServiceInitial extends BookedServiceState {}

//this state for all order

class AllOrderLoadingState extends BookedServiceState {}

class AllOrderSuccessState extends BookedServiceState {
  final List<OrderedServiceModel> orders;
  AllOrderSuccessState({required this.orders});
}

class AllOrderFailedState extends BookedServiceState {
  final String message;
  AllOrderFailedState({required this.message});
}

//this state for active order

class ActiveOrderLoadingState extends BookedServiceState {}

class ActiveOrderSuccessState extends BookedServiceState {
  final List<OrderedServiceModel> orders;
  ActiveOrderSuccessState({required this.orders});
}

class ActiveOrderFailedState extends BookedServiceState {
  final String message;
  ActiveOrderFailedState({required this.message});
}
