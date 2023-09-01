import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/car_screen.dart';
import 'package:flutter_academy_day1/styling.dart';
import 'package:flutter_academy_day1/widgets/car_item.dart';

import 'models/car.dart';

class Cars extends StatefulWidget {
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  final List<Car> cars = [
    Car(name: "BMW X6", date: DateTime(2022, 9, 10)),
    Car(name: "Audi Q7", date: DateTime(2021, 2, 3)),
    Car(name: "Fiat Punto", date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cars',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF111111),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: gradient,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemBuilder: (ctx, index) {
            final car = cars[index];
            return Dismissible(
              key: ValueKey(car.id),
              onDismissed: (direction) {
                setState(() {
                  cars.remove(car);
                });
              },
              child: CarItem(car: cars[index]),
            );
          },
          itemCount: cars.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CarScreen(
                onAddCarr: (car) {
                  setState(() {
                    cars.add(car);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
