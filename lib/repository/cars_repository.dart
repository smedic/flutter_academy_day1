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

  Future<void> deleteCar(String carId) async {
    try {
      await DioClient.instance.delete(carPath(carId));
    } catch (ex) {
      rethrow;
    }
  }

// List<Car> _createDummyCars() {
//   return [
//     Car(
//       name: 'A8',
//       manufacturer: 'Audi',
//       price: 70000,
//       year: 2020,
//       lastRegistrationDate: DateTime(2022, 10, 9),
//       fuelType: FuelType.petrol,
//     ),
//     Car(
//       name: 'X6',
//       manufacturer: 'BMW',
//       price: 50000,
//       year: 2017,
//       lastRegistrationDate: DateTime(2022, 9, 8),
//       fuelType: FuelType.hybrid,
//     ),
//     Car(
//       name: 'X',
//       manufacturer: 'Tesla',
//       price: 65000,
//       year: 2022,
//       lastRegistrationDate: DateTime(2022, 8, 7),
//       fuelType: FuelType.electric,
//     ),
//     Car(
//       name: 'A4',
//       manufacturer: 'Audi',
//       price: 22500,
//       year: 2018,
//       lastRegistrationDate: DateTime(2022, 8, 7),
//       fuelType: FuelType.petrol,
//     ),
//     Car(
//       name: 'M4',
//       manufacturer: 'BMW',
//       price: 102000,
//       year: 2023,
//       lastRegistrationDate: DateTime(2023, 9, 8),
//       fuelType: FuelType.diesel,
//     ),
//   ];
// }
}
