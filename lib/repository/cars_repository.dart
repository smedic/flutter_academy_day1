import 'package:flutter_academy_day1/models/car.dart';

class CarsRepository {
  Future<List<Car>> fetchCars() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => _createDummyCars(),
    );
  }

  List<Car> _createDummyCars() {
    return [
      Car(
        name: 'A8',
        manufacturer: 'Audi',
        price: 70000,
        year: 2020,
        lastRegistrationDate: DateTime(2022, 10, 9),
        fuelType: FuelType.petrol,
      ),
      Car(
        name: 'X6',
        manufacturer: 'BMW',
        price: 50000,
        year: 2017,
        lastRegistrationDate: DateTime(2022, 9, 8),
        fuelType: FuelType.hybrid,
      ),
      Car(
        name: 'X',
        manufacturer: 'Tesla',
        price: 65000,
        year: 2022,
        lastRegistrationDate: DateTime(2022, 8, 7),
        fuelType: FuelType.electric,
      ),
      Car(
        name: 'A4',
        manufacturer: 'Audi',
        price: 22500,
        year: 2018,
        lastRegistrationDate: DateTime(2022, 8, 7),
        fuelType: FuelType.petrol,
      ),
      Car(
        name: 'M4',
        manufacturer: 'BMW',
        price: 102000,
        year: 2023,
        lastRegistrationDate: DateTime(2023, 9, 8),
        fuelType: FuelType.diesel,
      ),
    ];
  }
}
