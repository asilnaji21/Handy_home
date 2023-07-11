import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/order_service_model.dart';
import 'package:handy_home_app/data/repository/bookedServiceRepository/booked_service_repository.dart';
import 'package:meta/meta.dart';

part 'booked_service_state.dart';

class BookedServiceCubit extends Cubit<BookedServiceState> {
  BookedServiceCubit() : super(BookedServiceInitial());

  BookedServiceRepository bookedServiceRepository = BookedServiceRepository();

  allOrders() async {
    emit(AllOrderLoadingState());

    final data = await bookedServiceRepository.allOrders();
    data.fold((l) {
      emit(AllOrderSuccessState(orders: l.data as List<OrderedServiceModel>));
    }, (r) => emit(AllOrderFailedState(message: r.message)));
  }

  activeOrders() async {
    emit(ActiveOrderLoadingState());

    final data = await bookedServiceRepository.activeOrder();
    data.fold((l) {
      emit(
          ActiveOrderSuccessState(orders: l.data as List<OrderedServiceModel>));
    }, (r) => emit(ActiveOrderFailedState(message: r.message)));
  }
}
