// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthInitialState extends AuthState {}

//this states for login
enum LoginStatus {
  loggedInSuccessfully,
  loggedInLoading,
  loggedInFailed,
}

class LoginState extends AuthState {
  LoginStatus loginCodeStatus;
  String? message;
  LoginState({required this.loginCodeStatus, this.message});
}

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

//this states for send code to reset password

enum SendResetCodeStatus { sendCodeSuccess, sendCodeLoading, sendCodeFailed }

class SendPasswordResetCodeState extends AuthState {
  SendResetCodeStatus sendResetCodeStatus;
  String? message;
  SendPasswordResetCodeState({required this.sendResetCodeStatus, this.message});
}

//this states for verify reset password code

enum VerifyResetPasswordCodeStatus { success, loading, failed }

class VerifyResetPasswordCodeState extends AuthState {
  VerifyResetPasswordCodeStatus verifyResetPasswordCodeStatus;
  dynamic data;
  VerifyResetPasswordCodeState(
      {required this.verifyResetPasswordCodeStatus, this.data});
}

// this states for reset new password
enum ResetNewPasswordStatus { success, loading, failed }

class ResetNewPasswordState extends AuthState {
  ResetNewPasswordStatus resetNewPasswordStatus;
  String? message;
  ResetNewPasswordState({required this.resetNewPasswordStatus, this.message});
}

// this states for resend code
enum ResendCodeStatus { success, loading, failed }

class ResendCodeState extends AuthState {
  ResendCodeStatus resendCodeStatus;
  String? message;
  ResendCodeState({required this.resendCodeStatus, this.message});
}

// this states for logout
enum LogoutStatus { success, loading, failed }

class LogoutState extends AuthState {
  LogoutStatus logoutStatus;
  String? message;
  LogoutState({required this.logoutStatus, this.message});
}
