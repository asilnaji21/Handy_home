import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/repository/authRepository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo = AuthRepository();
  AuthCubit() : super(RegisterInitialState());

  register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    emit(RegisterLoadingState());

    final data = await authRepo.userRegister(
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
}
