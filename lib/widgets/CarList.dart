import 'package:academy_app/models/Cars.dart';
import 'package:academy_app/widgets/CarItem.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  final List<Car> cars;
  final ValueChanged<Car>? onRemoveCar;
  final ValueChanged<Car>? onCarClicked;

  const CarList({
    super.key,
    required this.cars,
    this.onRemoveCar,
    this.onCarClicked,
  });

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: cars.length,
      itemBuilder: (ctx, index) {
        final car = cars[index];
        return Dismissible(
          key: ValueKey(car),
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          onDismissed: (_) {
            onRemoveCar?.call(car);
          },
          child: InkWell(
            onTap: () => onCarClicked?.call(car),
            child: CarItem(car),
          ),
        );
      },
    );
  }
}
