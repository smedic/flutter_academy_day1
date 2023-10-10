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
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.price,
    required this.year,
    required this.lastRegistrationDate,
    required this.fuelType,
  });

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

  factory Car.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final manufacturer = json['manufacturer'];
    final price = json['price'];
    final lastRegistrationDate = json['lastRegistrationDate'];
    final year = json['year'];
    final fuelType = FuelType.values.firstWhere((e) => e.name == json['fuelType']);
    return Car(
      name: name,
      manufacturer: manufacturer,
      price: price,
      year: year,
      lastRegistrationDate: formatter.parse(lastRegistrationDate),
      fuelType: fuelType,
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manufacturer': manufacturer,
      'price': price,
      'lastRegistrationDate': formattedDate,
      'fuelType': fuelType.name,
      'year': year,
    };
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
