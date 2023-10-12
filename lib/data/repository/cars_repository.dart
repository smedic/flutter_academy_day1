import 'dart:convert';

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
  Future<String> addNewCar(Car car) async {
    try {
      final Map<String, dynamic> response = await DioClient.instance
          .post(carsPath, data: json.encode(car.toJson()));
      return response['name'];
    } on DioException {
      rethrow;
    }
  }

  Future<String> editCar(Car car) async {
    try {
      final response = await DioClient.instance
          .put(carPath(car.id), data: json.encode(car.toJson()));
      return response['name'];
    } on DioException {
      rethrow;
    }
  }

  Future<void> deleteCar(String carId) async {
    try {
      await DioClient.instance.delete(carPath(carId));
    } on DioException {
      rethrow;
    }
  }
}
