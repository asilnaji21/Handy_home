import 'package:bloc/bloc.dart';
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
}