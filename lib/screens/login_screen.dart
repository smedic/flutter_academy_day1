import 'package:flutter/material.dart';
import 'package:flutter_academy_day1/decorations.dart';
import 'package:flutter_academy_day1/widgets/CustomButton.dart';

import 'cars_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: mainDecoration,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/flutter-logo.png',
                width: 150,
              ),
              const SizedBox(height: 12),
              const Text(
                'Welcome',
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'User Name',
                  hintText: 'Enter valid mail id as abc@gmail.com',
                  hintStyle: TextStyle(color: Color(0xFF555555)),
                ),
                style: TextStyle(color: Color(0xFF333333)),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your secure password',
                  hintStyle: TextStyle(
                    color: Color(0xFF555555),
                  ),
                ),
                style: TextStyle(color: Color(0xFF333333)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?',
                    style: TextStyle(color: Color(0xFF333333))),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => const CarsScreen()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Color(0xFF333333)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Press me',
                onClick: () => print('On click'),
                icon: const Icon(Icons.access_alarm_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
