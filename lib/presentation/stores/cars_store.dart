import 'package:dio/dio.dart';
import 'package:flutter_academy_day1/data/repository/cars_repository.dart';
import 'package:flutter_academy_day1/domain/models/car.dart';
import 'package:mobx/mobx.dart';

part 'cars_store.g.dart';

class CarsStore extends _CarsStore with _$CarsStore {}

abstract class _CarsStore with Store {
  final carsRepository = CarsRepository();
  final List<Car> _allCars = [];

  @observable
  bool isLoading = false;

  @readonly
  ObservableList<Car> _filteredCars = ObservableList<Car>();

  @observable
  ObservableList<String> selectedCarManufacturers = ObservableList<String>();

  @computed
  bool get isFilterApplied {
    return selectedCarManufacturers.isNotEmpty;
  }

  _CarsStore() {
    _setupReactions();
  }

  ReactionDisposer? _disposer;

  void _setupReactions() {
    _disposer = reaction((p0) => selectedCarManufacturers.iterator, (items) {
      _filterCars();
    });
  }

  void addCar(final Car car) {
    _allCars.add(car);
    _filterCars();
  }

  void removeSelectedCarManufacturer(final String manufacturer) {
    selectedCarManufacturers.remove(manufacturer);
    _filterCars();
  }

  void editCar(final Car editedCar) {
    final indexOfEditedCar =
        _allCars.indexWhere((car) => car.id == editedCar.id);
    _allCars.removeAt(indexOfEditedCar);
    _allCars.insert(indexOfEditedCar, editedCar);
    _filterCars();
  }

  (int, int) removeCar(final Car car) {
    final carIndexInAllList = _allCars.indexOf(car);
    final carIndexInFilteredList = _filteredCars.indexOf(car);
    _allCars.remove(car);
    _filteredCars.remove(car);
    return (carIndexInAllList, carIndexInFilteredList);
  }

  void _filterCars() {
    _filteredCars.clear();
    if (selectedCarManufacturers.isNotEmpty) {
      final cars = _allCars
          .where(
            (car) => selectedCarManufacturers
                .where((element) => element
                    .toLowerCase()
                    .contains(car.manufacturer.toLowerCase()))
                .isNotEmpty,
          )
          .toList();
      _filteredCars = ObservableList.of(cars);
    } else {
      _filteredCars = ObservableList.of(_allCars);
    }
  }

  void dispose() {
    _disposer?.call();
  }

  Future fetchCars() async {
    isLoading = true;
    try {
      final cars = await carsRepository.fetchCars();
      _allCars.addAll(cars);
      _filteredCars.addAll(cars);
    } on DioException catch(ex){

    } finally {
      isLoading = false;
    }
  }

  Future<String?> addNewCar(Car car) async {
    isLoading = true;
    try {
      return await carsRepository.addNewCar(car);
    } catch (ex) {
      return null;
    } finally {
      isLoading = false;
    }
  }
}
