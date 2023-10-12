import 'package:academy_app/bloc/CarsBloc.dart';
import 'package:academy_app/bloc/CarsEvent.dart';
import 'package:academy_app/bloc/CarsState.dart';
import 'package:academy_app/decorations.dart';
import 'package:academy_app/models/Cars.dart';
import 'package:academy_app/screens/car_screen.dart';
import 'package:academy_app/widgets/CarList.dart';
import 'package:academy_app/widgets/EmptyListPlaceholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      BlocProvider.of<CarsBloc>(context)
          .add(SearchEvent(_searchController.text));
    });
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
    BlocProvider.of<CarsBloc>(context).add(RemoveCarEvent(car));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Car deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            BlocProvider.of<CarsBloc>(context).add(UndoRemoveCarEvent(car));
          },
        ),
      ),
    );
  }

  void _editCar(Car editedCar) {
    BlocProvider.of<CarsBloc>(context).add(EditCarEvent(editedCar));
  }

  void _addCar(Car car) {
    BlocProvider.of<CarsBloc>(context).add(AddCarEvent(car));
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
        child: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            if (state is CarsLoadedState) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          onTap: () {
                            _showBottomSheet();
                          },
                          child: Icon(
                            Icons.filter_list_outlined,
                            color: state.selectedCarManufacturers.isNotEmpty
                                ? Colors.blue
                                : Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state.selectedCarManufacturers.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    _selectedManufacturersList(state.selectedCarManufacturers),
                  ],
                  Expanded(child: renderCarsList(state)),
                ],
              );
            } else {
              return const Spacer();
            }
          },
        ),
      ),
    );
  }

  Widget renderCarsList(CarsState state) {
    if (state is CarsLoadedState) {
      if (state.filteredCars.isEmpty) {
        return const EmptyListPlaceholder();
      }
      return CarList(
        cars: state.filteredCars,
        onRemoveCar: _removeCar,
        onCarClicked: _onCarClicked,
      );
    } else {
      return const Spacer();
    }
  }

  Widget _selectedManufacturersList(List<String> selectedCarManufacturers) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 4.0,
        direction: Axis.horizontal,
        children: [
          for (final manufacturer in selectedCarManufacturers)
            InkWell(
              onTap: () {
                BlocProvider.of<CarsBloc>(context)
                    .add(ToggleManufacturerEvent(manufacturer));
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
      builder: (context) => BlocBuilder<CarsBloc, CarsState>(
        builder: (context, carsState) {
          if (carsState is CarsLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      'Select car model',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
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
                              value: carsState.selectedCarManufacturers
                                  .contains(manufacturer),
                              onChanged: (isSelected) {
                                BlocProvider.of<CarsBloc>(context)
                                    .add(ToggleManufacturerEvent(manufacturer));
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
          return const Spacer();
        },
      ),
    );
  }
}
