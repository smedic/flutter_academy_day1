// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cars_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CarsStore on _CarsStore, Store {
  Computed<bool>? _$isFilterAppliedComputed;

  @override
  bool get isFilterApplied =>
      (_$isFilterAppliedComputed ??= Computed<bool>(() => super.isFilterApplied,
              name: '_CarsStore.isFilterApplied'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_CarsStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_filteredCarsAtom =
      Atom(name: '_CarsStore._filteredCars', context: context);

  ObservableList<Car> get filteredCars {
    _$_filteredCarsAtom.reportRead();
    return super._filteredCars;
  }

  @override
  ObservableList<Car> get _filteredCars => filteredCars;

  @override
  set _filteredCars(ObservableList<Car> value) {
    _$_filteredCarsAtom.reportWrite(value, super._filteredCars, () {
      super._filteredCars = value;
    });
  }

  late final _$selectedCarManufacturersAtom =
      Atom(name: '_CarsStore.selectedCarManufacturers', context: context);

  @override
  ObservableList<String> get selectedCarManufacturers {
    _$selectedCarManufacturersAtom.reportRead();
    return super.selectedCarManufacturers;
  }

  @override
  set selectedCarManufacturers(ObservableList<String> value) {
    _$selectedCarManufacturersAtom
        .reportWrite(value, super.selectedCarManufacturers, () {
      super.selectedCarManufacturers = value;
    });
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
selectedCarManufacturers: ${selectedCarManufacturers},
isFilterApplied: ${isFilterApplied}
    ''';
  }
}
