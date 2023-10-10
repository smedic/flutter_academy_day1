import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_academy_day1/models/car.dart';
import 'package:flutter_academy_day1/networking/dio_client.dart';

import '../networking/paths.dart';

class CarsRepository {
  Future<List<Car>> fetchCars() async {
    try {
      final response = await DioClient.instance.get(carsPath);
      final list = response.entries.map((json) => Car.fromJson(json)).toList();
      return list;
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> addNewCar(Car car) async {
    try {
      final response = await DioClient.instance
          .post(carsPath, data: json.encode(car.toJson()));
      return response['name'];
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> editCar(Car car) async {
    try {
      final response = await DioClient.instance
          .put(carsPath, data: json.encode(car.toJson()));
      return response['name'];
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> deleteCar(String carId) async {
    try {
      await DioClient.instance.delete(carPath(carId));
    } catch (ex) {
      rethrow;
    }
  }
}
