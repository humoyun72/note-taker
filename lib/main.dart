import 'package:flutter/material.dart';
import 'package:note_taker/core/dependencies/injections.dart';
import 'package:note_taker/features/home_screen/screen.dart';

void main() {
  initAppDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not taker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
