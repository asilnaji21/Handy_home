import 'package:bloc/bloc.dart';
import 'package:handy_home_app/data/repository/home/home_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository = HomeRepository();

  HomeCubit() : super(HomeInitial());

  categories() async {
    emit(CategoryLoadingState());

    final data = await homeRepository.getCategory();
    data.fold((l) {
      List<CategoryModel> categories = l.data as List<CategoryModel>;
      emit(CategorySuccessState(categories: categories));
    }, (r) => emit(CategoryFailedState(message: r.message)));
  }
}
