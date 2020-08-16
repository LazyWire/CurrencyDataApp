// import 'package:myfirstapp/helpers/dataHelper.dart';
import 'package:get_it/get_it.dart';
import 'package:myfirstapp/services/currencyService.dart';



GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => CurrencyDataService());
}