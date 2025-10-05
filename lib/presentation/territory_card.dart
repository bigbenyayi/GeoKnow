import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/screen/territory_list_screen.dart';
import 'package:geo_know/screen/territory_screen.dart';
import 'package:geo_know/values/countries.dart';
import 'package:geo_know/values/territories.dart';

class TerritoryCard extends StatelessWidget {
  final Territory _territory;

  const TerritoryCard({
    super.key,
    required Territory territory,
  }) : _territory = territory;

  @override
  Widget build(BuildContext context) {
    final List<FlashcardContent>? flashcardContent = _territory is Country
        ? Countries.flashcardContent[_territory.isoCode]
        : Territories.flashcardContent[_territory.isoCode];
    return GestureDetector(
      onTap: () {
        if (_territory.isoCode == 'us' && _territory is Country) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return TerritoryListScreen(country: _territory as Country);
              },
            ),
          );
        } else if (flashcardContent != null) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return TerritoryScreen(territory: _territory);
              },
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        foregroundDecoration: BoxDecoration(
          color: flashcardContent != null || _territory.isoCode == 'us' && _territory is Country
              ? Colors.transparent
              : Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        ),
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
                CircleFlag(_territory.isoCodeCircleFlag, size: 30.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _territory.name,
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
                      _territory.asset,
                      color: Theme.of(context).primaryColor.withValues(alpha: .3),
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      _territory.asset,
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
