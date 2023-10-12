import 'package:academy_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/CarsBloc.dart';
import 'bloc/CarsEvent.dart';

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
