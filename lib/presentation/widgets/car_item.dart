import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/domain/models/car.dart';

class CarItem extends StatelessWidget {
  const CarItem(
    this.car, {
    super.key,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${car.manufacturer} ${car.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 4),
                Icon(fuelTypeIcons[car.fuelType]),
                const Spacer(),
                Text('${car.year}. yr.'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '\$${car.price.toStringAsFixed(2)}',
                  ),
                ),
                const Text('Date posted: '),
                Text(car.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
