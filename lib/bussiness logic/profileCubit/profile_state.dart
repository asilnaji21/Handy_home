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

// this state for verify password request
class VerifyPasswordLoadingState extends ProfileState {}

class VerifyPasswordSuccessState extends ProfileState {
  final String message;
  VerifyPasswordSuccessState({required this.message});
}

class VerifyPasswordFailedState extends ProfileState {
  final String message;
  VerifyPasswordFailedState({required this.message});
}

// this state for change email request
class ChangeEmailLoadingState extends ProfileState {}

class ChangeEmailSuccessState extends ProfileState {
  final String message;
  ChangeEmailSuccessState({required this.message});
}

class ChangeEmailFailedState extends ProfileState {
  final String message;
  ChangeEmailFailedState({required this.message});
}

// this state for verify new email code request
class VerifyNewEmailLoadingState extends ProfileState {}

class VerifyNewEmailSuccessState extends ProfileState {
  final String message;
  VerifyNewEmailSuccessState({required this.message});
}

class VerifyNewEmailFailedState extends ProfileState {
  final String message;
  VerifyNewEmailFailedState({required this.message});
}

// this state for get location list request
class LocationLoadingState extends ProfileState {}

class LocationSuccessState extends ProfileState {
  final List<LocationModel> locations;
  LocationSuccessState({required this.locations});
}

class LocationFailedState extends ProfileState {
  final String message;
  LocationFailedState({required this.message});
}

// this state for add new location request
class AddLocationLoadingState extends ProfileState {}

class AddLocationSuccessState extends ProfileState {
  final String message;
  AddLocationSuccessState({required this.message});
}

class AddLocationFailedState extends ProfileState {
  final String message;
  AddLocationFailedState({required this.message});
}

// this state for delete location request

class DeleteState {}

class DeleteLocationLoadingState extends DeleteState {}

class DeleteLocationSuccessState extends DeleteState {
  final String message;
  DeleteLocationSuccessState({required this.message});
}

class DeleteLocationFailedState extends DeleteState {
  final String message;
  DeleteLocationFailedState({required this.message});
}

// this state for delete location request

class EditState {}

class EditLoadingState extends EditState {}

class EditSuccessState extends EditState {
  final String message;
  EditSuccessState({required this.message});
}

class EditFailedState extends EditState {
  final String message;
  EditFailedState({required this.message});
}

