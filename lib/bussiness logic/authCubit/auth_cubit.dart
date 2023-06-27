import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/user_model.dart';
import 'package:handy_home_app/data/repository/authRepository/auth_repository.dart';
import '../../app/locator.dart';
import '../../data/network/local/local_network.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo = AuthRepository();
  AuthCubit() : super(RegisterInitialState());

  login({required String email, required String password}) async {
    emit(LoginState(loginCodeStatus: LoginStatus.loggedInLoading));

    final data = await authRepo.login(
      email: email,
      password: password,
    );
    data.fold(
        (l){
          getIt<SharedPrefController>().save(l.data as UserModel);
           emit(LoginState(
            loginCodeStatus: LoginStatus.loggedInSuccessfully,
            message: 'Logged in successfully'));},
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
}
