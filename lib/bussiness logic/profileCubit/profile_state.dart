part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


// this states for become service provider


class BecomeServiceProviderLoadingState extends ProfileState {}

class BecomeServiceProviderSuccessState extends ProfileState {
  final ServiceProviderModel serviceProvider;
  BecomeServiceProviderSuccessState({required this.serviceProvider});
}

class BecomeServiceProviderFailedState extends ProfileState {
  final String message;
  BecomeServiceProviderFailedState({required this.message});
}
