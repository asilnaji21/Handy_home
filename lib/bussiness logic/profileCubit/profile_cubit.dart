import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/location_model.dart';
import 'package:handy_home_app/data/models/service_provider_model.dart';
import 'package:handy_home_app/data/models/user_info_model.dart';
import 'package:handy_home_app/data/repository/profileRepository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileRepository profileRepository = ProfileRepository();

  becomeServiceProvider(
      {required String name,
      required String phone,
      required String location,
      required int yearExperience,
      required String summaryExperience,
      required String additional,
      required int category}) async {
    emit(BecomeServiceProviderLoadingState());

    final data = await profileRepository.becomeServiceProvider(
      name: name,
      phone: phone,
      location: location,
      yearExperience: yearExperience,
      summaryExperience: summaryExperience,
      additional: additional,
      category: category,
    );
    data.fold((l) {
      emit(BecomeServiceProviderSuccessState(
          serviceProvider: l.data as ServiceProviderModel));
    }, (r) => emit(BecomeServiceProviderFailedState(message: r.message)));
  }

  getUserInfo() async {
    emit(UserInfoLoadingState());

    final data = await profileRepository.getUserInfo();
    data.fold((l) {
      emit(UserInfoSuccessState(userInfoModel: l.data as UserInfoModel));
    }, (r) => emit(UserInfoFailedState(message: r.message)));
  }

  editPersonalInfo({
    required String firstName,
    required String lastName,
  }) async {
    emit(EditPersonalInfoLoadingState());

    final data = await profileRepository.editUserInfo(
      firstName: firstName,
      lastName: lastName,
    );
    data.fold((l) {
      emit(EditPersonalInfoSuccessState(message: l.data as String));
    }, (r) => emit(EditPersonalInfoFailedState(message: r.message)));
  }

  verifyPassword({required String password}) async {
    emit(VerifyPasswordLoadingState());

    final data = await profileRepository.verifyPassword(password: password);
    data.fold((l) {
      emit(VerifyPasswordSuccessState(message: l.data as String));
    }, (r) => emit(VerifyPasswordFailedState(message: r.message)));
  }

  changeEmail({required String email}) async {
    emit(ChangeEmailLoadingState());

    final data = await profileRepository.changeEmail(email: email);
    data.fold((l) {
      emit(ChangeEmailSuccessState(message: l.data as String));
    }, (r) => emit(ChangeEmailFailedState(message: r.message)));
  }

  verifyNewEmail({required String code}) async {
    emit(VerifyNewEmailLoadingState());

    final data = await profileRepository.verifyNewEmail(code: code);
    data.fold((l) {
      emit(VerifyNewEmailSuccessState(message: l.data as String));
    }, (r) => emit(VerifyNewEmailFailedState(message: r.message)));
  }

  getLocation() async {
    emit(LocationLoadingState());

    final data = await profileRepository.getLocation();
    data.fold((l) {
      emit(LocationSuccessState(locations: l.data as List<LocationModel>));
    }, (r) => emit(LocationFailedState(message: r.message)));
  }

  addNewLocation({
    required String country,
    required String city,
    required String building,
    required String apartmentNumber,
    required String phoneNumber,
  }) async {
    emit(AddLocationLoadingState());

    final data = await profileRepository.addNewLocation(
      country: country,
      city: city,
      building: building,
      apartmentNumber: apartmentNumber,
      phoneNumber: phoneNumber,
    );
    data.fold((l) {
      emit(AddLocationSuccessState(message: l.data as String));
    }, (r) => emit(AddLocationFailedState(message: r.message)));
  }
}

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit() : super(DeleteState());
  ProfileRepository profileRepository = ProfileRepository();

  deleteLocation({required String endPoint}) async {
    emit(DeleteLocationLoadingState());

    final data = await profileRepository.deleteLocation(endpoint: endPoint);
    data.fold((l) {
      emit(DeleteLocationSuccessState(message: l.data as String));
    }, (r) => emit(DeleteLocationFailedState(message: r.message)));
  }
}

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditState());
  ProfileRepository profileRepository = ProfileRepository();

  editLocation({
    required String endpoint,
    required String country,
    required String city,
    required String building,
    required String apartmentNumber,
    required String phoneNumber,
  }) async {
    emit(EditLoadingState());
    print('ddddddddddd');
    final data = await profileRepository.editLocation(
      endpoint: endpoint,
      country: country,
      city: city,
      building: building,
      apartmentNumber: apartmentNumber,
      phoneNumber: phoneNumber,
    );
    data.fold((l) {
      emit(EditSuccessState(message: l.data as String));
    }, (r) => emit(EditFailedState(message: r.message)));
  }
}
