import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/territory_card.dart';
import 'package:geo_know/values/countries.dart';

class CountryListScreen extends StatelessWidget {
  final Continent _continent;

  const CountryListScreen({super.key, required Continent continent}) : _continent = continent;

  @override
  Widget build(BuildContext context) {
    final List<Country> countries = CountryEnum.getCountries(_continent);
    return Scaffold(
      appBar: CustomAppBar(title: _continent.readableName),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          final Country country = countries[index];
          return TerritoryCard(territory: country);
        },
      ),
    );
  }
}
