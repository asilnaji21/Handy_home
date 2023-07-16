part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}
// this for read notification

class ReadNotificationInitial extends NotificationState {}

class ReadNotificationLoading extends NotificationState {}

class ReadNotificationFailed extends NotificationState {
  final String message;
  ReadNotificationFailed({required this.message});
}

class ReadNotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  ReadNotificationSuccess({
    required this.notifications,
  });
}

// this for unread notification
abstract class NotificationUnReadState {}

class NotificationUnreadInitial extends NotificationUnReadState {}

class UnreadNotificationLoading extends NotificationUnReadState {}

class UnreadNotificationFailed extends NotificationUnReadState {
  final String message;
  UnreadNotificationFailed({required this.message});
}

class UnreadNotificationSuccess extends NotificationUnReadState {
  final List<NotificationModel> notifications;
  UnreadNotificationSuccess({
    required this.notifications,
  });
}
