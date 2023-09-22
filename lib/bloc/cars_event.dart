import 'package:equatable/equatable.dart';

import '../models/car.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();
}

class GetAllCarsEvent extends CarsEvent {
  const GetAllCarsEvent();

  @override
  List<Object?> get props => [];
}

class AddCarEvent extends CarsEvent {
  const AddCarEvent({required this.carObj});

  final Car carObj;

  @override
  List<Object?> get props => [carObj];
}

class RemoveCarEvent extends CarsEvent {
  const RemoveCarEvent({required this.carObj});

  final Car carObj;

  @override
  List<Object?> get props => [carObj];
}
