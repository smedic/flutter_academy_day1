import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/bloc/cars_bloc.dart';
import 'package:flutter_academy_day1/bloc/cars_event.dart';
import 'package:flutter_academy_day1/bloc/cars_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _searchController = TextEditingController();

  // final List<Car> _allCars = createDummyCars();
  //
  // List<Car> _filteredCars = [];
  final List<String> _selectedCarManufacturers = [];

  @override
  void initState() {
    _searchController.addListener(_filterCars);
    // _filteredCars = [..._allCars];
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
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

  void _removeCar(final Car car) {
    BlocProvider.of<CarsBloc>(context).add(RemoveCarEvent(carObj: car));
    // final carIndexInAllList = _allCars.indexOf(car);
    // final carIndexInFilteredList = _filteredCars.indexOf(car);
    // setState(() {
    //   _allCars.remove(car);
    //   _filteredCars.remove(car);
    // });
    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     duration: const Duration(seconds: 3),
    //     content: const Text('Car deleted'),
    //     action: SnackBarAction(
    //       label: 'Undo',
    //       onPressed: () {
    //         setState(() {
    //           _allCars.insert(carIndexInAllList, car);
    //           _filteredCars.insert(carIndexInFilteredList, car);
    //         });
    //       },
    //     ),
    //   ),
    // );
  }

  void _editCar(Car editedCar) {
    //   final indexOfEditedCar =
    //       _allCars.indexWhere((car) => car.id == editedCar.id);
    //   _allCars.removeAt(indexOfEditedCar);
    //   _allCars.insert(indexOfEditedCar, editedCar);
    //   _filterCars();
  }

  //
  void _addCar(Car car) {
    BlocProvider.of<CarsBloc>(context).add(AddCarEvent(carObj: car));
    // _allCars.add(car);
    // _filterCars();
  }

  void _filterCars() {
    // ScaffoldMessenger.of(context).clearSnackBars();
    // setState(() {
    //   final searchText = _searchController.text.toLowerCase();
    //
    //   _filteredCars = [..._allCars];
    //
    //   //apply search term
    //   if (searchText.isNotEmpty) {
    //     _filteredCars = _filteredCars
    //         .where((car) =>
    //             ("${car.manufacturer.toLowerCase()} ${car.name.toLowerCase()}")
    //                 .contains(searchText.toLowerCase()))
    //         .toList();
    //   }
    //
    //   //apply filter by manufacturer
    //   if (_selectedCarManufacturers.isNotEmpty) {
    //     _filteredCars = _filteredCars
    //         .where((car) => _selectedCarManufacturers
    //             .where((element) => element
    //                 .toLowerCase()
    //                 .contains(car.manufacturer.toLowerCase()))
    //             .isNotEmpty)
    //         .toList();
    //   }
    // });
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
                      color: _selectedCarManufacturers.isNotEmpty
                          ? Colors.blue
                          : Colors.black,
                    ),
                  )
                ],
              ),
            ),
            if (_selectedCarManufacturers.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              _selectedManufacturersList(),
            ],
            Expanded(
              child: BlocBuilder<CarsBloc, CarsState>(
                builder: (BuildContext context, CarsState state) {
                  if (state is EmptyCarsState) {
                    return EmptyListPlaceholder();
                  } else if (state is LoadedCarsState) {
                    return CarList(
                      cars: state.cars,
                      onRemoveCar: _removeCar,
                      onCarClicked: _onCarClicked,
                    );
                  } else {
                    return const Spacer();
                  }
                },
              ),
            )
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
          for (final manufacturer in _selectedCarManufacturers)
            InkWell(
              onTap: () {
                setState(() {
                  _selectedCarManufacturers.remove(manufacturer);
                  _filterCars();
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
                  return StatefulBuilder(
                    builder: (context, state) {
                      final manufacturer = carManufacturers[index];
                      return CheckboxListTile(
                        title: Text(manufacturer),
                        value: _selectedCarManufacturers.contains(manufacturer),
                        onChanged: (isSelected) {
                          state(() {
                            if (isSelected ?? false) {
                              _selectedCarManufacturers.add(manufacturer);
                            } else {
                              _selectedCarManufacturers.remove(manufacturer);
                            }
                          });
                          setState(() {});
                          _filterCars();
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
