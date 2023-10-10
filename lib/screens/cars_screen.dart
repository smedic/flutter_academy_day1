import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/stores/cars_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../decorations.dart';
import '../models/car.dart';
import '../widgets/car_list.dart';
import '../widgets/empty_list_placeholder.dart';
import 'car_screen.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final _store = CarsStore();

  final _searchController = TextEditingController();

  final List<Car> _allCars = [];

  @override
  void initState() {
    _store.fetchCars();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _store.dispose();
    super.dispose();
  }

  void _onCarClicked(final Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => CarScreen(
          onAddCar: _addCar,
          onEditCar: _editCar,
          car: car,
        ),
      ),
    );
  }

  //TODO
  void _removeCar(final Car car) {
    final (carIndexInAllList, carIndexInFilteredList) = _store.removeCar(car);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Car deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _allCars.insert(carIndexInAllList, car);
                _store.filteredCars.insert(carIndexInFilteredList, car);
              },
            );
          },
        ),
      ),
    );
  }

  void _editCar(final Car editedCar) => _store.editCar(editedCar);

  void _addCar(Car car) {
    _store.addCar(car);
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cars',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF111111),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) =>
                  CarScreen(onAddCar: _addCar, onEditCar: _editCar),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: mainDecoration,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  InkWell(
                    onTap: _showBottomSheet,
                    child: Icon(
                      Icons.filter_list_outlined,
                      color:
                          _store.isFilterApplied ? Colors.blue : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Observer(
              builder: (_) => _store.isFilterApplied
                  ? _selectedManufacturersList()
                  : Container(),
            ),
            Observer(
              builder: (BuildContext context) {
                if (_store.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: _store.filteredCars.isEmpty
                      ? const EmptyListPlaceholder()
                      : CarList(
                          cars: _store.filteredCars,
                          onRemoveCar: _removeCar,
                          onCarClicked: _onCarClicked,
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedManufacturersList() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 4.0,
        direction: Axis.horizontal,
        children: [
          for (final manufacturer in _store.selectedCarManufacturers)
            InkWell(
              onTap: () {
                setState(() {
                  _store.removeSelectedCarManufacturer(manufacturer);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(manufacturer),
                    const Icon(Icons.close, size: 16),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Select car model',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: carManufacturers.length,
                itemBuilder: (context, index) {
                  final manufacturer = carManufacturers[index];
                  return Observer(
                    builder: (BuildContext context) {
                      return CheckboxListTile(
                        title: Text(manufacturer),
                        value: _store.selectedCarManufacturers
                            .contains(manufacturer),
                        onChanged: (isSelected) {
                          if (isSelected ?? false) {
                            _store.selectedCarManufacturers.add(manufacturer);
                          } else {
                            _store.selectedCarManufacturers
                                .remove(manufacturer);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
