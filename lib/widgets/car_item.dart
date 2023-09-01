import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/models/Car.dart';

class CarItem extends StatelessWidget {
  const CarItem({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Text(
            car.name,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
