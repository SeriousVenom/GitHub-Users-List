import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user_list/domain/repositories/main/abstract_main_repository.dart';
import 'package:github_user_list/domain/repositories/main/main_repository.dart';

void diRegister() {
  Dio dio = Dio();

  GetIt.I.registerLazySingleton<AbstractMainRepository>(
    () => MainRepository(
      dio: dio,
    ),
  );
}
