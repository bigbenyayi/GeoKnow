import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/screen/territory_list_screen.dart';
import 'package:geo_know/screen/territory_screen.dart';
import 'package:geo_know/util/circle_flag.dart';

class FavoriteCard extends StatelessWidget {
  final VoidCallback _onTap;
  final Continent _continent;

  const FavoriteCard({
    super.key,
    required Continent continent,
    required void Function() onTap,
  }) : _continent = continent, _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
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
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                  child: Icon(Icons.favorite, color: Theme.of(context).primaryColor, size: 16.0),
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Favorites',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      _continent.asset,
                      color: Theme.of(context).primaryColor.withValues(alpha: .3),
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      _continent.asset,
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
