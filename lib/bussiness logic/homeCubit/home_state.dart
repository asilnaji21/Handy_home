part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//this states for category

class CategoryLoadingState extends HomeState {}

class CategorySuccessState extends HomeState {
  final List<CategoryModel> categories;
  CategorySuccessState({required this.categories});
}

class CategoryFailedState extends HomeState {
  final String message;
  CategoryFailedState({required this.message});
}
