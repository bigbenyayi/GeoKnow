import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/screen/country_screen.dart';

class CountryCard extends StatelessWidget {
  final Country _country;

  const CountryCard({
    super.key,
    required Country country,
  }) : _country = country;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return CountryScreen(country: _country);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
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
                CircleFlag(_country.isoCode, size: 30.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _country.name,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Center(
                child: Stack(
                  children: <Image>[
                    Image.asset(
                      _country.asset,
                      color: Theme.of(context).primaryColor.withOpacity(.3),
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      _country.asset,
                      color: Colors.grey.shade300,
                      height: 97,
                      width: 97,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}