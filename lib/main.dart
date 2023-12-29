import 'package:flutter/material.dart';
import 'package:geo_know/screen/continent_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Prompt',
        colorScheme: ColorScheme.fromSeed(primary: const Color(0xFF004830), seedColor: const Color(0xFF004830)),
        useMaterial3: true,
      ),
      home: const ContinentListScreen(),
    );
  }
}