import 'package:dio/dio.dart';
import 'package:flutter_academy_day1/data/networking/dio_client.dart';
import 'package:flutter_academy_day1/data/networking/paths.dart';
import 'package:flutter_academy_day1/domain/models/car.dart';

class CarsRepository {
  Future<List<Car>> fetchCars() async {
    try {
      final Map<String, dynamic> response =
          await DioClient.instance.get(carsPath);
      return response.entries
          .map((jsonMapEntry) => Car.fromJson(jsonMapEntry))
          .toList();
    } on DioException catch (ex) {
      rethrow;
    }
  }
}
