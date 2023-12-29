import 'package:flutter/material.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/territory_card.dart';
import 'package:geo_know/values/territories.dart';

class TerritoryListScreen extends StatelessWidget {
  final Country _country;

  const TerritoryListScreen({super.key, required Country country}) : _country = country;

  @override
  Widget build(BuildContext context) {
    final List<Territory> territories = Territories.territories.toList();
    return Scaffold(
      appBar: CustomAppBar(title: _country.name),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: territories.length,
        itemBuilder: (BuildContext context, int index) {
          final Territory territory = territories[index];
          return TerritoryCard(territory: territory);
        },
      ),
    );
  }
}
