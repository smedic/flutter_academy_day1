import 'package:equatable/equatable.dart';
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

class Car extends Equatable {
  const Car({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.price,
    required this.year,
    required this.lastRegistrationDate,
    required this.fuelType,
  });

  final String id;
  final String name;
  final String manufacturer;
  final double price;
  final DateTime lastRegistrationDate;
  final int year;
  final FuelType fuelType;

  String get formattedDate {
    return formatter.format(lastRegistrationDate);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        manufacturer,
        price,
        lastRegistrationDate,
        year,
        fuelType,
      ];

  Car copyWith({
    String? id,
    String? name,
    String? manufacturer,
    double? price,
    DateTime? lastRegistrationDate,
    int? year,
    FuelType? fuelType,
  }) {
    return Car(
      id: id ?? this.id,
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      price: price ?? this.price,
      lastRegistrationDate: lastRegistrationDate ?? this.lastRegistrationDate,
      year: year ?? this.year,
      fuelType: fuelType ?? this.fuelType,
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
