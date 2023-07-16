import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/notification_model.dart';
import 'package:handy_home_app/data/repository/notificationRepository/notificationiRepository.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(ReadNotificationInitial());
  NotificationRepository notificationRepository = NotificationRepository();

  readNotification() async {
    emit(ReadNotificationLoading());
    final data = await notificationRepository.getReadNotification();
    data.fold((l) {
      List<NotificationModel> notifications = l.data as List<NotificationModel>;
      emit(ReadNotificationSuccess(notifications: notifications));
    }, (r) => emit(ReadNotificationFailed(message: r.message)));
  }

  changeNotification() async {
    // emit(ReadNotificationLoading());
    final data = await notificationRepository.getReadNotification();
    data.fold((l) {
    print(l.data);
    }, (r) => emit(ReadNotificationFailed(message: r.message)));
  }

}

class NotificationUnReadCubit extends Cubit<NotificationUnReadState> {
  NotificationUnReadCubit() : super(NotificationUnreadInitial());
  NotificationRepository notificationRepository = NotificationRepository();

  unreadNotification() async {
    emit(UnreadNotificationLoading());
    final data = await notificationRepository.getUnreadNotification();
    data.fold((l) {
      List<NotificationModel> notifications = l.data as List<NotificationModel>;
      emit(UnreadNotificationSuccess(notifications: notifications));
    }, (r) => emit(UnreadNotificationFailed(message: r.message)));
  }
}
