import 'package:flutter_academy_day1/data/networking/dio_client.dart';
import 'package:flutter_academy_day1/data/repository/cars_repository.dart';
import 'package:flutter_academy_day1/presentation/stores/cars_store.dart';
import 'package:get_it/get_it.dart';

final class DI {
  static void setup() {
    GetIt.I.registerSingleton<DioClient>(DioClient());
    GetIt.I.registerSingleton<CarsRepository>(
        CarsRepository(GetIt.I.get<DioClient>()));
    GetIt.I.registerFactory<CarsStore>(() {
      final repo = GetIt.I.get<CarsRepository>();
      return CarsStore(repo);
    });
  }

  static T get<T extends Object>() {
    return GetIt.I.get<T>();
  }
}
