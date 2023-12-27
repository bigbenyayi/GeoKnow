import 'package:flutter/material.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/stateus.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/stateus_card.dart';
import 'package:geo_know/values/statesus.dart';

class StatesUSScreen extends StatelessWidget {
  final Country _country;

  const StatesUSScreen({super.key, required Country country}) : _country = country;

  @override
  Widget build(BuildContext context) {
    final List<StateUS> statesus = StatesUS.statesus.toList();
    return Scaffold(
      appBar: CustomAppBar(title: _country.name),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: statesus.length,
        itemBuilder: (BuildContext context, int index) {
          final StateUS stateUS = statesus[index];
          return StateUSCard(stateUS: stateUS);
        },
      ),
    );
  }
}
