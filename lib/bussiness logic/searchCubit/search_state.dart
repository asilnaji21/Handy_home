part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<ServiceModel> services;
  SearchSuccessState({required this.services});
}

class SearchFailedState extends SearchState {
  final String message;
  SearchFailedState({required this.message});
}
