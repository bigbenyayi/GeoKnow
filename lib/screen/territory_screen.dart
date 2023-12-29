import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/values/countries.dart';
import 'package:geo_know/values/territories.dart';

class TerritoryScreen extends StatefulWidget {
  final Territory _territory;

  const TerritoryScreen({super.key, required Territory territory}) : _territory = territory;

  @override
  State<TerritoryScreen> createState() => _TerritoryScreenState();
}

class _TerritoryScreenState extends State<TerritoryScreen> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final List<FlashcardContent> flashcards = widget._territory is Country
        ? Countries.flashcardContent[widget._territory.isoCode]!
        : Territories.flashcardContent[widget._territory.isoCode]!;
    return Scaffold(
      appBar: CustomAppBar(title: widget._territory.name),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: CardSwiper(
              cardsCount: flashcards.length,
              padding: const EdgeInsets.only(top: 64.0),
              onSwipe: (int oldIndex, int? newIndex, __) {
                _index.value = newIndex!;
                return true;
              },
              cardBuilder: (BuildContext context, int index, int x, int y) {
                final FlashcardContent flashcard = flashcards[index];
                return Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: <Container>[
                    Container(
                      height: 516.0,
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black26, blurRadius: 16.0, spreadRadius: 4, offset: Offset(0, 3))
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: SvgPicture.asset(
                            widget._territory.flag,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, .0),
                                child: Image.network(
                                  flashcard.image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: HtmlWidget(
                                  flashcard.text,
                                  textStyle: const TextStyle(color: Color(0xff333333), fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _index,
            builder: (BuildContext context, int index, _) {
              return Flexible(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 64.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        child: LinearProgressIndicator(
                          value: (index + 1) / flashcards.length,
                          minHeight: 8.0,
                          color: Colors.grey.shade400,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${index + 1}/${flashcards.length}',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12.0),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}