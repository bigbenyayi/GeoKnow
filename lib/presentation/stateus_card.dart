import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/stateus.dart';
import 'package:geo_know/screen/stateus_screen.dart';
import 'package:geo_know/values/statesus.dart';

class StateUSCard extends StatelessWidget {
  final StateUS _stateUS;

  const StateUSCard({
    super.key,
    required StateUS stateUS,
  }) : _stateUS = stateUS;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final List<FlashcardContent>? flashcardContent = StatesUS.flashcardContent[_stateUS.isoCode];
        if (flashcardContent != null) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return StateUSScreen(stateUS: _stateUS);
              },
            ),
          );
        }
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
                CircleFlag(_stateUS.isoCode, size: 30.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _stateUS.name,
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
                      _stateUS.asset,
                      color: Theme.of(context).primaryColor.withOpacity(.3),
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      _stateUS.asset,
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