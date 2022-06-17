

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mvvm_project/app/app_prefs.dart';
import 'package:mvvm_project/data/data_source/local_data_source.dart';
import 'package:mvvm_project/data/data_source/remote_data_source.dart';
import 'package:mvvm_project/data/network/app_api.dart';
import 'package:mvvm_project/data/network/dio_factory.dart';
import 'package:mvvm_project/data/network/network_info.dart';
import 'package:mvvm_project/data/repository/repository_impl.dart';
import 'package:mvvm_project/domain/repository/repository.dart';
import 'package:mvvm_project/domain/usecase/home_usecase.dart';
import 'package:mvvm_project/presentation/home/home_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance=GetIt.instance;

Future<void> initAppModule() async{
 final sharedPrefs = await SharedPreferences.getInstance();
 // shared prefs instance
 instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
 instance.registerLazySingleton(() => AppPreferences(instance()));

 // networl instance
 instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));
  // dio factory
 instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

 // app service client
 final dio=await instance<DioFactory>().getDio();
 instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

 // remote data source
 instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

 // local data source
 instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplementer());

 // repository

 instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(),instance()));


}

initLoginModel() {
 if (!GetIt.I.isRegistered<LoginUseCase>()) {
  instance.registerFactory<LoginUseCase>(
          () => LoginUseCase(instance()));
  instance.registerFactory<CharactersViewModel>(() =>
      CharactersViewModel(instance()));
 }
}
