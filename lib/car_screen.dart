import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/models/Car.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key, required this.onAddCarr});

  final Function(Car car) onAddCarr;

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Add new car',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF111111),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          OutlinedButton(
              onPressed: () {
                final car = Car(
                  name: _nameController.text,
                  date: DateTime.now(),
                );
                widget.onAddCarr(car);
                Navigator.pop(context);
              },
              child: Text('save'))
        ],
      ),
    );
  }
}
