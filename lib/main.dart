import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/di/di.dart';
import 'package:flutter_academy_day1/presentation/screens/login_screen.dart';

void main() {
  DI.setup();
  runApp(
    MaterialApp(
      home: const StartScreen(),
      theme: ThemeData(useMaterial3: true),
    ),
  );
}
