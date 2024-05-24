import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_1/bloc/search_bloc.dart';
import 'package:test_1/contants/constants.dart';
import 'package:test_1/network/api_service.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 1),
        receiveTimeout: const Duration(seconds: 1),
        sendTimeout: const Duration(seconds: 1),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Constants.TOKEN}'
        },
      )));

  getIt.registerLazySingleton<ApiService>(() => ApiServiceIpml(getIt()));

  getIt.registerFactory<SearchBloc>(() => SearchBloc(getIt()));
}
