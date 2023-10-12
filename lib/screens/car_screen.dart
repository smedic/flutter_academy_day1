import 'package:academy_app/decorations.dart';
import 'package:academy_app/models/Cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({
    super.key,
    required this.onAddCar,
    required this.onEditCar,
    this.car,
  });

  final void Function(Car) onAddCar;
  final void Function(Car) onEditCar;
  final Car? car;

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _nameController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  FuelType _selectedFuelType = FuelType.petrol;

  DateTime? _selectedDate;

  @override
  void initState() {
    if (widget.car != null) {
      _manufacturerController.text = widget.car!.manufacturer;
      _nameController.text = widget.car!.name;
      _yearController.text = widget.car!.year.toString();
      _priceController.text = widget.car!.price.toString();
      _selectedFuelType = widget.car!.fuelType;
      _selectedDate = widget.car!.lastRegistrationDate;
    }
    super.initState();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveCarData() {
    final price = double.tryParse(_priceController.text);
    final year = int.tryParse(_yearController.text);
    final invalidPrice = price == null || price <= 0;
    final invalidYear = year == null || year <= 1900;
    final invalidData = _nameController.text.isEmpty ||
        _manufacturerController.text.isEmpty ||
        invalidPrice ||
        invalidYear ||
        _selectedDate == null;
    if (invalidData) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, price, year, licence date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    final car = Car(
      id: widget.car?.id ?? const Uuid().v4(),
      name: _nameController.text,
      manufacturer: _manufacturerController.text,
      price: price,
      year: year,
      lastRegistrationDate: _selectedDate!,
      fuelType: _selectedFuelType,
    );
    if (widget.car == null) {
      widget.onAddCar(car);
    } else {
      widget.onEditCar(car);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _yearController.dispose();
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
          widget.car == null ? 'Add new car' : 'Edit car',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF111111),
      ),
      body: Container(
        decoration: mainDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _manufacturerController,
                          maxLength: 50,
                          decoration: const InputDecoration(label: Text('Manufacturer')),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          maxLength: 50,
                          decoration: const InputDecoration(label: Text('Model')),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _priceController,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Price'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _yearController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                          ],
                          decoration: const InputDecoration(
                            label: Text('Year'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Licence date'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton(
                          value: _selectedFuelType,
                          items: FuelType.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toString().toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedFuelType = value;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _saveCarData,
                      child: const Text('Save car'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
