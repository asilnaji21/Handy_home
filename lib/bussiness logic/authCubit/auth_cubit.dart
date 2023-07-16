import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/user_model.dart';
import 'package:handy_home_app/data/repository/authRepository/auth_repository.dart';
import '../../app/locator.dart';
import '../../data/models/verify_reset_password_code_model.dart';
import '../../data/network/local/local_network.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo = AuthRepository();
  AuthCubit() : super(AuthInitialState());

  login({required String email, required String password}) async {
    emit(LoginState(loginCodeStatus: LoginStatus.loggedInLoading));

    final data = await authRepo.login(
      email: email,
      password: password,
    );
    data.fold((l) {
      getIt<SharedPrefController>().save(l.data as UserModel);
      getIt<SharedPrefController>().isLoggedIn(value: true);
      emit(LoginState(
          loginCodeStatus: LoginStatus.loggedInSuccessfully,
          message: 'تم تسجيل الدخول بنجاح'));
    },
        (r) => emit(LoginState(
              loginCodeStatus: LoginStatus.loggedInFailed,
              message: r.message.toString(),
            )));
  }

  register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());

    final data = await authRepo.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
    data.fold((l) => emit(RegisterSuccessState(message: l.data)),
        (r) => emit(RegisterFailureState(errorMessage: r.message)));
  }

  verifyCode({required String code}) async {
    emit(VerifyCodeState(verifyCodeStatus: VerifyCodeStatus.verifyLoading));

    final data = await authRepo.verifyCode(code: code);

    data.fold(
      (l) => emit(VerifyCodeState(
          verifyCodeStatus: VerifyCodeStatus.verifySuccess, message: l.data)),
      (r) => emit(
        VerifyCodeState(
          verifyCodeStatus: VerifyCodeStatus.verifyFailed,
          message: r.message.toString(),
        ),
      ),
    );
  }

  sendResetPasswordCode({required String email}) async {
    emit(SendPasswordResetCodeState(
        sendResetCodeStatus: SendResetCodeStatus.sendCodeLoading));

    final data = await authRepo.sendCodeToResetPassword(email: email);

    data.fold(
      (l) => emit(SendPasswordResetCodeState(
          sendResetCodeStatus: SendResetCodeStatus.sendCodeSuccess,
          message: l.data.toString())),
      (r) => emit(
        SendPasswordResetCodeState(
            sendResetCodeStatus: SendResetCodeStatus.sendCodeFailed,
            message: r.message.toString()),
      ),
    );
  }

  verifyResetPasswordCode({required String code}) async {
    emit(VerifyResetPasswordCodeState(
        verifyResetPasswordCodeStatus: VerifyResetPasswordCodeStatus.loading));

    final data = await authRepo.verifyResetPasswordCode(code: code);

    data.fold(
      (l) => emit(VerifyResetPasswordCodeState(
          verifyResetPasswordCodeStatus: VerifyResetPasswordCodeStatus.success,
          data: l.data as ResetPasswordCodeModel)),
      (r) => emit(VerifyResetPasswordCodeState(
          data: r.message,
          verifyResetPasswordCodeStatus: VerifyResetPasswordCodeStatus.failed)),
    );
  }

  resetNewPassword({required String token, required String newPassword}) async {
    emit(ResetNewPasswordState(
        resetNewPasswordStatus: ResetNewPasswordStatus.loading));

    final data =
        await authRepo.resetNewPassword(token: token, newPassword: newPassword);

    data.fold(
        (l) => emit(ResetNewPasswordState(
            resetNewPasswordStatus: ResetNewPasswordStatus.success,
            message: l.data.toString())),
        (r) => emit(ResetNewPasswordState(
            resetNewPasswordStatus: ResetNewPasswordStatus.loading,
            message: r.message.toString())));
  }

  resendCode({required String email}) async {
    emit(ResendCodeState(resendCodeStatus: ResendCodeStatus.loading));

    final data = await authRepo.resendCode(email: email);

    data.fold(
        (l) => emit(ResendCodeState(
            resendCodeStatus: ResendCodeStatus.success, message: l.data)),
        (r) => emit(ResendCodeState(
            resendCodeStatus: ResendCodeStatus.failed, message: r.message)));
  }

  logout({required String refresh}) async {
    emit(LogoutState(logoutStatus: LogoutStatus.loading));

    final data = await authRepo.logout(refresh: refresh);

    data.fold(
      (l) => emit(
          LogoutState(logoutStatus: LogoutStatus.success, message: l.data)),
      (r) => emit(
        LogoutState(
          logoutStatus: LogoutStatus.failed,
          message: r.message,
        ),
      ),
    );
  }
}
