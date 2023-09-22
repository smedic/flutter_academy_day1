import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/bloc/cars_bloc.dart';
import 'package:flutter_academy_day1/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CarsBloc(),
      child: MaterialApp(
        home: const StartScreen(),
        theme: ThemeData(useMaterial3: true),
      ),
    ),
  );
}
