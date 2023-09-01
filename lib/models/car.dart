import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Car {
  Car({
    required this.name,
    required this.date,
  }) : id = uuid.v4();

  String id;
  String name;
  DateTime date;
}
