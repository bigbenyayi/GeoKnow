import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/flashcard_design.dart';
import 'package:geo_know/util/asset_json_util.dart';

class TerritoryScreen extends StatefulWidget {
  final Territory _territory;

  const TerritoryScreen({
    super.key,
    required Territory territory,
  }) : _territory = territory;

  @override
  State<TerritoryScreen> createState() => _TerritoryScreenState();
}

class _TerritoryScreenState extends State<TerritoryScreen> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(false);

  List<FlashcardContent> _flashcards = <FlashcardContent>[];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  /// Load flashcards once
  Future<void> _loadFlashcards() async {
    final List<FlashcardContent> cards = await AssetJsonUtil.loadFlashcards(
      countryCode: widget._territory.isoCode,
    );

    setState(() {
      _flashcards = cards;
      if (cards.isNotEmpty) {
        _isFavorite.value = cards.first.isFavorite;
      } else {
        _isFavorite.value = false;
      }
    });
  }

  /// Toggle favorite and save to shared prefs
  Future<void> _toggleFavorite() async {
    _isFavorite.value = !_isFavorite.value;

    // Update current flashcard favorite state
    final int currentIndex = _index.value;
    if (currentIndex < _flashcards.length) {
      _flashcards[currentIndex] = _flashcards[currentIndex].copyWith(isFavorite: _isFavorite.value);
    }

    // Save in SharedPrefs
    if (_isFavorite.value) {
      await SharedPrefsHelper.addCountryValue(
        widget._territory.isoCode,
        _index.value,
      );
    } else {
      await SharedPrefsHelper.removeCountryValue(
        widget._territory.isoCode,
        _index.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading state before flashcards are ready
    if (_flashcards.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: widget._territory.name,
        action: ValueListenableBuilder<bool>(
          valueListenable: _isFavorite,
          builder: (BuildContext context, bool isFavorite, _) {
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color(0xFF004830),
              ),
              onPressed: _toggleFavorite,
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 10,
            child: CardSwiper(
              cardsCount: _flashcards.length,
              padding: const EdgeInsets.only(top: 64.0),
              onSwipe: (int oldIndex, int? newIndex, _) {
                if (newIndex != null && newIndex < _flashcards.length) {
                  _index.value = newIndex;
                  _isFavorite.value = _flashcards[newIndex].isFavorite;
                }
                return true;
              },
              cardBuilder: (BuildContext context, int index, int x, int y) {
                final FlashcardContent flashcard = _flashcards[index];
                return FlashcardDesign(
                  flag: widget._territory.flag,
                  flashcard: flashcard,
                  isFirst: index == 0,
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
                          value: (index + 1) / _flashcards.length,
                          minHeight: 8.0,
                          color: Colors.grey.shade400,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${index + 1}/${_flashcards.length}',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12.0),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
