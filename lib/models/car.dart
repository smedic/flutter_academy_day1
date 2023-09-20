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
  Car({
    required this.name,
    required this.manufacturer,
    required this.price,
    required this.year,
    required this.lastRegistrationDate,
    required this.fuelType,
  }) : id = uuid.v4();

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

List<Car> createDummyCars() {
  return [
    Car(
      name: 'A8',
      manufacturer: 'Audi',
      price: 70000,
      year: 2020,
      lastRegistrationDate: DateTime(2022, 10, 9),
      fuelType: FuelType.petrol,
    ),
    Car(
      name: 'X6',
      manufacturer: 'BMW',
      price: 50000,
      year: 2017,
      lastRegistrationDate: DateTime(2022, 9, 8),
      fuelType: FuelType.hybrid,
    ),
    Car(
      name: 'X',
      manufacturer: 'Tesla',
      price: 65000,
      year: 2022,
      lastRegistrationDate: DateTime(2022, 8, 7),
      fuelType: FuelType.electric,
    ),
    Car(
      name: 'A4',
      manufacturer: 'Audi',
      price: 22500,
      year: 2018,
      lastRegistrationDate: DateTime(2022, 8, 7),
      fuelType: FuelType.petrol,
    ),
    Car(
      name: 'M4',
      manufacturer: 'BMW',
      price: 102000,
      year: 2023,
      lastRegistrationDate: DateTime(2023, 9, 8),
      fuelType: FuelType.diesel,
    ),
  ];
}
