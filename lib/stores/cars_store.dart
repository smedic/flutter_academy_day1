import 'package:flutter_academy_day1/models/car.dart';
import 'package:mobx/mobx.dart';

part 'cars_store.g.dart';

class CarsStore extends _CarsStore with _$CarsStore {}

abstract class _CarsStore with Store {
  final List<Car> _allCars = createDummyCars();

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
    _filteredCars.addAll(_allCars);
    fetchCars();
  }

  ReactionDisposer? _disposer;

  void _setupReactions() {
    _disposer = reaction((p0) => selectedCarManufacturers.iterator, (items) {
      print("List changed: ${_filteredCars.length}");
      _filterCars();
    });
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

  void fetchCars() {}
}
