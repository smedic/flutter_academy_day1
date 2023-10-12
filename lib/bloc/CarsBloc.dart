import 'package:academy_app/bloc/CarsState.dart';
import 'package:academy_app/models/Cars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:stream_transform/stream_transform.dart';

import 'CarsEvent.dart';

const uuid = Uuid();

const debounceDuration = Duration(milliseconds: 300);

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(CarsInitialState()) {
    on<LoadAllCarsEvent>(_onStart);
    on<AddCarEvent>(_addCar);
    on<RemoveCarEvent>(_removeCar);
    on<EditCarEvent>(_editCar);
    on<UndoRemoveCarEvent>(_undoRemoveCar);
    on<ToggleManufacturerEvent>(_manufacturerFilter);
    on<SearchEvent>(
      _searchFilter,
      transformer: (events, mapper) =>
          events.debounce(debounceDuration).switchMap(mapper),
    );
  }

  final List<Car> allCars = _createDummyCars();

  _onStart(LoadAllCarsEvent event, Emitter<CarsState> emit) {
    if (state is! CarsLoadedState) {
      emit(CarsLoadedState(allCars: [...allCars], filteredCars: [...allCars]));
    }
  }

  _addCar(AddCarEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      emit(
        state.copyWith(
          allCars: [...state.allCars, event.carObj],
          filteredCars: _filterAllCars(
              state.allCars, state.searchTerm, state.selectedCarManufacturers),
        ),
      );
    } else {
      emit(CarsLoadedState(
        allCars: [event.carObj],
        filteredCars: [event.carObj],
      ));
    }
  }

  _removeCar(RemoveCarEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      final List<Car> cars = state.allCars;
      final carIndexInAllList = cars.indexOf(event.carObj);
      cars.removeAt(carIndexInAllList);
      final List<Car> filteredCars = state.filteredCars;
      final carIndexInFilteredList = filteredCars.indexOf(event.carObj);
      filteredCars.removeAt(carIndexInFilteredList);
      emit(
        state.copyWith(
          allCars: [...cars],
          lastRemovedCarIndex: carIndexInAllList,
          filteredCars: [...filteredCars],
          lastRemovedFilteredCarIndex: carIndexInFilteredList,
        ),
      );
    }
  }

  _undoRemoveCar(UndoRemoveCarEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      int? lastIndex = state.lastRemovedCarIndex;
      if (lastIndex == null) return;
      final List<Car> cars = state.allCars;
      cars.insert(lastIndex, event.carObj);
      int? lastFilterIndex = state.lastRemovedFilteredCarIndex;
      if (lastFilterIndex == null) return;
      final List<Car> filteredCars = state.filteredCars;
      filteredCars.insert(lastFilterIndex, event.carObj);
      emit(state.copyWith(
        allCars: [...cars],
        filteredCars: [...filteredCars],
      ));
    }
  }

  _editCar(EditCarEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      final List<Car> cars = List.from(state.allCars);
      final indexOfEditedCar = cars.indexWhere(
        (car) => car.id == event.carObj.id,
      );
      cars.removeAt(indexOfEditedCar);
      cars.insert(indexOfEditedCar, event.carObj);
      emit(
        state.copyWith(
          allCars: [...cars],
          filteredCars: _filterAllCars(
              cars, state.searchTerm, state.selectedCarManufacturers),
        ),
      );
    }
  }

  _searchFilter(SearchEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      final List<Car> cars = List.from(state.allCars);
      emit(
        state.copyWith(
          filteredCars: _filterAllCars(
            cars,
            event.searchTerm,
            state.selectedCarManufacturers,
          ),
          searchTerm: state.searchTerm,
        ),
      );
    }
  }

  _manufacturerFilter(ToggleManufacturerEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is CarsLoadedState) {
      final List<String> manufacturers = List.from(state.selectedCarManufacturers);
      bool isSelected = manufacturers.contains(event.manufacturer);
      if (isSelected) {
        manufacturers.remove(event.manufacturer);
        emit(
          state.copyWith(
            filteredCars: _filterAllCars(
              state.allCars,
              state.searchTerm,
              manufacturers,
            ),
            selectedCarManufacturers: [...manufacturers],
          ),
        );
      } else {
        List<String> addedManufacturers = [
          ...manufacturers,
          event.manufacturer,
        ];
        emit(
          state.copyWith(
            filteredCars: _filterAllCars(
              state.allCars,
              state.searchTerm,
              addedManufacturers,
            ),
            selectedCarManufacturers: addedManufacturers,
          ),
        );
      }
    }
  }

  _filterAllCars(List<Car> allCars, String searchTerm,
      List<String> selectedCarManufacturers) {
    List<Car> filteredCars = [...allCars];
    if (searchTerm.isNotEmpty) {
      filteredCars = filteredCars
          .where((car) =>
              ("${car.manufacturer.toLowerCase()} ${car.name.toLowerCase()}")
                  .contains(searchTerm.toLowerCase()))
          .toList();
    }
    if (selectedCarManufacturers.isNotEmpty) {
      filteredCars = filteredCars
          .where((car) => selectedCarManufacturers
              .where((element) => element
                  .toLowerCase()
                  .contains(car.manufacturer.toLowerCase()))
              .isNotEmpty)
          .toList();
    }
    return filteredCars;
  }
}

List<Car> _createDummyCars() {
  return [
    Car(
      id: uuid.v4(),
      name: 'A8',
      manufacturer: 'Audi',
      price: 70000,
      year: 2020,
      lastRegistrationDate: DateTime(2022, 10, 9),
      fuelType: FuelType.petrol,
    ),
    Car(
      id: uuid.v4(),
      name: 'X6',
      manufacturer: 'BMW',
      price: 50000,
      year: 2017,
      lastRegistrationDate: DateTime(2022, 9, 8),
      fuelType: FuelType.hybrid,
    ),
    Car(
      id: uuid.v4(),
      name: 'X',
      manufacturer: 'Tesla',
      price: 65000,
      year: 2022,
      lastRegistrationDate: DateTime(2022, 8, 7),
      fuelType: FuelType.electric,
    ),
    Car(
      id: uuid.v4(),
      name: 'A4',
      manufacturer: 'Audi',
      price: 22500,
      year: 2018,
      lastRegistrationDate: DateTime(2022, 8, 7),
      fuelType: FuelType.petrol,
    ),
    Car(
      id: uuid.v4(),
      name: 'M4',
      manufacturer: 'BMW',
      price: 102000,
      year: 2023,
      lastRegistrationDate: DateTime(2023, 9, 8),
      fuelType: FuelType.diesel,
    ),
  ];
}
