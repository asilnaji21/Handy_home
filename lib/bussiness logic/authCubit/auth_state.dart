// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

// this states for register
class RegisterInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final String message;

  RegisterSuccessState({required this.message});
}

class RegisterFailureState extends AuthState {
  final String errorMessage;

  RegisterFailureState({required this.errorMessage});
}

//this states for verify code

enum VerifyCodeStatus { verifySuccess, verifyLoading, verifyFailed }

class VerifyCodeState extends AuthState {
  VerifyCodeStatus verifyCodeStatus;
  String? message;
  VerifyCodeState({required this.verifyCodeStatus, this.message});
}
