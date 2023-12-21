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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 500,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: const BoxDecoration(
              color: Color(0xFF86a298),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black26, blurRadius: 4.0, spreadRadius: .5, offset: Offset(0, 3))
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Image.network(
                      'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/e546fb8e-26d3-4684-9c6d-23d723478b44/ui_remover.png?format=1500w',
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'The lines in Kenya are white not like the people' * 5,
                        style: const TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: LinearProgressIndicator(
                value: .55,
                minHeight: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
