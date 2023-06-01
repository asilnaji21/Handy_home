
import 'package:get_it/get_it.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';

final getIt = GetIt.instance;
void setUp() {
  getIt.registerLazySingleton<NavigationManager>(
      () =>NavigationManager());
}
