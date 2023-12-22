import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/screen/countries_screen.dart';

class ContinentsScreen extends StatelessWidget {
  const ContinentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(
                'GeoKnow',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 50.0,
                ),
              ),
              scrolledUnderElevation: .0,
            ),
            ListView.builder(
              itemCount: Continent.values.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16.0),
              itemBuilder: (BuildContext context, int index) {
                final Continent continent = Continent.values[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return CountriesScreen(continent: continent);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black26, blurRadius: 4.0, spreadRadius: .5, offset: Offset(0, 3))
                        ]),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            continent.readableName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Image>[
                              Image.asset(
                                continent.asset,
                                color: Colors.grey.shade300,
                                height: 100,
                                width: 100,
                              ),
                              Image.asset(
                                continent.asset,
                                width: 97,
                                height: 97,
                                color: const Color(0xFF86a298),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}