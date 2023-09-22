import 'package:equatable/equatable.dart';

import '../models/car.dart';

abstract class CarsState extends Equatable {
  const CarsState();
}

class InitialCarsState extends CarsState {
  const InitialCarsState();

  @override
  List<Object?> get props => [];
}

class EmptyCarsState extends CarsState {
  const EmptyCarsState();

  @override
  List<Object?> get props => [];
}

class LoadedCarsState extends CarsState {
  const LoadedCarsState({required this.cars});

  final List<Car> cars;

  @override
  List<Object?> get props => [cars];
}
