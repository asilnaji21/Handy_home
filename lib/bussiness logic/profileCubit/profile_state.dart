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

// this states for user info

class UserInfoLoadingState extends ProfileState {}

class UserInfoSuccessState extends ProfileState {
  final UserInfoModel userInfoModel;
  UserInfoSuccessState({required this.userInfoModel});
}

class UserInfoFailedState extends ProfileState {
  final String message;
  UserInfoFailedState({required this.message});
}

// this state for edit user info request 
class EditPersonalInfoLoadingState extends ProfileState {}

class EditPersonalInfoSuccessState extends ProfileState {
  final String message;
  EditPersonalInfoSuccessState({required this.message});
}

class EditPersonalInfoFailedState extends ProfileState {
  final String message;
  EditPersonalInfoFailedState({required this.message});
}
