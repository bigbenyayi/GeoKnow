import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/flashcard_design.dart';
import 'package:geo_know/util/asset_json_util.dart';
import 'package:geo_know/values/countries.dart';

class FavoriteScreen extends StatefulWidget {
  final Continent? _continent;

  const FavoriteScreen({super.key, Continent? continent}) : _continent = continent;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(false);
  final CardSwiperController _controller = CardSwiperController();

  List<FlashcardContent>? _flashcards;

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  /// Load flashcards once
  Future<void> _loadFlashcards() async {
    final List<FlashcardContent> cards = await SharedPrefsHelper.loadAllFavoriteFlashcards();
    if (widget._continent != null) {
      cards.retainWhere(
          (FlashcardContent card) => CountryEnum.fromIsoCode(card.isoCode).continent == widget._continent);
    }
    setState(() {
      _flashcards = cards;
      if (_index.value >= cards.length) {
        return;
      }
      if (cards.isNotEmpty) {
        _isFavorite.value = cards[_index.value].isFavorite;
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
    if (currentIndex < _flashcards!.length) {
      _flashcards![currentIndex] = _flashcards![currentIndex].copyWith(isFavorite: _isFavorite.value);
    }
    _controller.swipe(CardSwiperDirection.bottom);
    _index.value = _flashcards!.length - 1 < _index.value ? _index.value++ : 0;
    _flashcards!.removeAt(currentIndex);
    await SharedPrefsHelper.removeGlobalFavorite(currentIndex);
    _loadFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading state before flashcards are ready
    if (_flashcards == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (_flashcards!.isEmpty) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(title: 'Favorites'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite_border, size: 80.0, color: Theme.of(context).primaryColor.withValues(alpha: .3)),
              const SizedBox(height: 16.0),
              Text(
                widget._continent != null
                    ? 'No favorites in ${widget._continent!.readableName}.'
                    : 'No favorites.',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final CountryEnum countryEnum = CountryEnum.fromIsoCode(_flashcards![_index.value].isoCode);
    final FlashcardContent flashcard = _flashcards![_index.value];
    return Scaffold(
      appBar: CustomAppBar(
        title: countryEnum.name,
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
            child: _flashcards!.length == 1
                ? FlashcardDesign(
                    flag: countryEnum.toCountry.flag,
                    flashcard: flashcard,
                    isFirst: false,
                  )
                : CardSwiper(
                    controller: _controller,
              cardsCount: _flashcards!.length,
              padding: const EdgeInsets.only(top: 64.0),
              onSwipe: (int oldIndex, int? newIndex, _) {
                if (newIndex != null && newIndex < _flashcards!.length) {
                  _index.value = newIndex;
                  _isFavorite.value = _flashcards![newIndex].isFavorite;
                  setState(() {});
                }
                return true;
              },
              cardBuilder: (BuildContext context, int index, int x, int y) {
                if (index >= _flashcards!.length) {
                  return const SizedBox();
                }
                final FlashcardContent flashcard = _flashcards![index];
                final String flag = CountryEnum.fromIsoCode(_flashcards![index].isoCode).toCountry.flag;
                return FlashcardDesign(
                  flag: flag,
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
                          value: (index + 1) / _flashcards!.length,
                          minHeight: 8.0,
                          color: Colors.grey.shade400,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${index + 1}/${_flashcards!.length}',
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
