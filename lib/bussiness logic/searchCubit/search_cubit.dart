import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/models/service_model.dart';
import 'package:handy_home_app/data/repository/searchRepository/search_repository.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchRepository searchRepository = SearchRepository();

  services({String? searchValue}) async {
    emit(SearchLoadingState());
    final data =
        await searchRepository.getAllServices(valueSearch: searchValue);
    data.fold((l) {
      List<ServiceModel> services = l.data as List<ServiceModel>;
      emit(SearchSuccessState(services: services));
    }, (r) => emit(SearchFailedState(message: r.message)));
  }
}
