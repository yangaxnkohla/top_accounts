import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/viewmodels/account_model.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => AccountModel());
}