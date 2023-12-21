import 'package:flutter/material.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';

class CountryScreen extends StatelessWidget {
  final Country _country;

  const CountryScreen({super.key, required Country country}) : _country = country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _country.name),
      body: Center(
        child: Container(
          color: Colors.red,
          height: 500,
          width:  300,
        )
      ),
    );
  }
}