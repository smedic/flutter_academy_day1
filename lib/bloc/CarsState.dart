import 'package:academy_app/models/Cars.dart';
import 'package:equatable/equatable.dart';

abstract class CarsState extends Equatable {
  const CarsState();
}

class CarsInitialState extends CarsState {
  @override
  List<Object?> get props => [];
}

class CarsLoadedState extends CarsState {
  const CarsLoadedState({
    this.allCars = const [],
    this.filteredCars = const [],
    this.lastRemovedCarIndex,
    this.lastRemovedFilteredCarIndex,
    this.searchTerm = "",
    this.selectedCarManufacturers = const [],
  });

  final List<Car> allCars;
  final List<Car> filteredCars;
  final int? lastRemovedCarIndex;
  final int? lastRemovedFilteredCarIndex;
  final String searchTerm;
  final List<String> selectedCarManufacturers;

  @override
  List<Object?> get props => [
        allCars,
        filteredCars,
        lastRemovedCarIndex,
        lastRemovedFilteredCarIndex,
        searchTerm,
        selectedCarManufacturers
      ];

  CarsLoadedState copyWith({
    List<Car>? allCars,
    List<Car>? filteredCars,
    int? lastRemovedCarIndex,
    int? lastRemovedFilteredCarIndex,
    String? searchTerm,
    List<String>? selectedCarManufacturers,
  }) {
    return CarsLoadedState(
      allCars: allCars ?? this.allCars,
      filteredCars: filteredCars ?? this.filteredCars,
      lastRemovedCarIndex: lastRemovedCarIndex,
      lastRemovedFilteredCarIndex: lastRemovedFilteredCarIndex,
      searchTerm: searchTerm ?? this.searchTerm,
      selectedCarManufacturers:
          selectedCarManufacturers ?? this.selectedCarManufacturers,
    );
  }
}
