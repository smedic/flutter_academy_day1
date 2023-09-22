import 'dart:async';

import 'package:flutter_academy_day1/bloc/cars_event.dart';
import 'package:flutter_academy_day1/bloc/cars_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/car.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc() : super(const InitialCarsState()) {
    on<GetAllCarsEvent>(_getAllCars);
    on<AddCarEvent>(_addCar);
    on<RemoveCarEvent>(_removeCar);
  }

  void _getAllCars(GetAllCarsEvent event, Emitter<CarsState> emit) {
    List<Car> cars = createDummyCars();
    emit(LoadedCarsState(cars: cars));
  }

  void _addCar(AddCarEvent event, Emitter<CarsState> emit) {
    Car car = event.carObj;
    final state = this.state;
    if (state is LoadedCarsState) {
      List<Car> cars = state.cars;
      cars.add(car);
      emit(LoadedCarsState(cars: [...cars, car]));
    } else if (state is EmptyCarsState) {
      emit(LoadedCarsState(cars: [car]));
    }
  }

  void _removeCar(RemoveCarEvent event, Emitter<CarsState> emit) {
    final state = this.state;
    if (state is LoadedCarsState) {
      List<Car> cars = state.cars;
      int lastRemovedCarIndex = cars.indexOf(event.carObj);
      cars.removeAt(lastRemovedCarIndex);
      if (cars.isEmpty) {
        emit(const EmptyCarsState());
      } else {
        emit(LoadedCarsState(cars: [...cars]));
      }
    }
  }
}
