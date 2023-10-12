import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum FuelType { petrol, diesel, electric, hybrid }

const Map<FuelType, IconData> fuelTypeIcons = {
  FuelType.petrol: Icons.local_gas_station,
  FuelType.diesel: Icons.local_gas_station_outlined,
  FuelType.electric: Icons.power,
  FuelType.hybrid: Icons.car_repair,
};

class Car {

  Car(
      {required this.name,
      required this.manufacturer,
      required this.price,
      required this.year,
      required this.lastRegistrationDate,
      required this.fuelType,
      String? id})
      : id = id ?? uuid.v4();

  String id;
  final String name;
  final String manufacturer;
  final double price;
  final DateTime lastRegistrationDate;
  final int year;
  final FuelType fuelType;

  String get formattedDate {
    return formatter.format(lastRegistrationDate);
  }

  factory Car.fromJson(MapEntry<String, dynamic> json) {
    final id = json.key;
    final carValues = json.value as Map<String, dynamic>;
    final name = carValues['name'];
    final manufacturer = carValues['manufacturer'];
    final price = carValues['price'];
    final lastRegistrationDate =
        formatter.parse(carValues['lastRegistrationDate']);
    final year = carValues['year'];
    final fuelType =
        FuelType.values.firstWhere((e) => e.name == carValues['fuelType']);
    return Car(
      id: id,
      name: name,
      manufacturer: manufacturer,
      price: price,
      year: year,
      lastRegistrationDate: lastRegistrationDate,
      fuelType: fuelType,
    );
  }
}

const carManufacturers = [
  'Audi',
  'BMW',
  'Toyota',
  'Tesla',
  'Peugeot',
  'Citroen',
  'Mercedes',
  'Opel',
  'Honda',
  'Suzuki',
];
