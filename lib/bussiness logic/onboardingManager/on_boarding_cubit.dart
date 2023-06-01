import 'package:bloc/bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState(currentIndex: 0));

  onSelectItem(int index) {
    emit(OnBoardingState(currentIndex: index));
  }
}
