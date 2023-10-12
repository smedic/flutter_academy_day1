import 'package:equatable/equatable.dart';

import '../models/Cars.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();
}

class LoadAllCarsEvent extends CarsEvent {
  @override
  List<Object?> get props => [];
}

class AddCarEvent extends CarsEvent {
  const AddCarEvent(this.carObj);

  final Car carObj;

  @override
  List<Object?> get props => [carObj];
}

class RemoveCarEvent extends CarsEvent {
  const RemoveCarEvent(this.carObj);

  final Car carObj;

  @override
  List<Object> get props => [carObj];
}

class UndoRemoveCarEvent extends CarsEvent {
  const UndoRemoveCarEvent(this.carObj);

  final Car carObj;

  @override
  List<Object> get props => [carObj];
}

class EditCarEvent extends CarsEvent {
  final Car carObj;

  const EditCarEvent(this.carObj);

  @override
  List<Object> get props => [carObj];
}

class SearchEvent extends CarsEvent {
  final String searchTerm;

  const SearchEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class ToggleManufacturerEvent extends CarsEvent {
  final String manufacturer;

  const ToggleManufacturerEvent(this.manufacturer);

  @override
  List<Object> get props => [manufacturer];
}
