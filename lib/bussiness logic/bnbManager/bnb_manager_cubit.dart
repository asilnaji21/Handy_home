import 'package:bloc/bloc.dart';

part 'bnb_manager_state.dart';

class BnbManagerCubit extends Cubit<BnbManagerState> {
  BnbManagerCubit() : super(BnbManagerState(selectedIndex: 0));

  onSelectItem(int index) {
    emit(BnbManagerState(selectedIndex: index));
  }
}
