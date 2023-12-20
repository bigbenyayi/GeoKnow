import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/values/countries.dart';

class CountriesScreen extends StatelessWidget {
  final Continent _continent;

  const CountriesScreen({super.key, required Continent continent}) : _continent = continent;

  @override
  Widget build(BuildContext context) {
    final List<Country> countries = Countries.countries.where((Country c) => c.continent == _continent).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(_continent.readableName,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black26, blurRadius: 4.0, spreadRadius: .5, offset: Offset(0, 3))
              ],
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleFlag(country.isoCode, size: 30.0,),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        country.name,
                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Stack(
                      children: <Image>[
                        Image.asset(
                          country.asset,
                          color: Theme.of(context).primaryColor.withOpacity(.3),
                          height: 103,
                          width: 103,
                        ),
                        Image.asset(
                          country.asset,
                          color: Colors.grey.shade300,
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}