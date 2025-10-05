import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/territory.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';
import 'package:geo_know/presentation/flashcard_design.dart';
import 'package:geo_know/screen/add_flashcard_screen.dart';
import 'package:geo_know/util/asset_json_util.dart';

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
    return Scaffold(
      appBar: _AppBar(territory: widget._territory),
      body: FutureBuilder<List<FlashcardContent>>(
        future: AssetJsonUtil.loadFlashcards(countryCode: widget._territory.isoCode),
        builder: (BuildContext context, AsyncSnapshot<List<FlashcardContent>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final List<FlashcardContent> flashcards = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: CardSwiper(
                  cardsCount: flashcards.length,
                  padding: const EdgeInsets.only(top: 64.0),
                  onSwipe: (int oldIndex, int? newIndex, __) {
                    _index.value = newIndex!;
                    return true;
                  },
                  cardBuilder: (BuildContext context, int index, int x, int y) {
                    final FlashcardContent flashcard = flashcards[index];
                    return FlashcardDesign(flag: widget._territory.flag, flashcard: flashcard);
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
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final Territory _territory;

  const _AppBar({
    Key? key,
    required Territory territory,
  })  : _territory = territory,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: _territory.name,
      action: PopupMenuButton<int>(
        icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor),
        onSelected: (int? index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return AddFlashcardScreen(territory: _territory);
                },
              ),
            );
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuItem<int>>[
            const PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: <Widget>[
                  Icon(Icons.add, color: Color(0xFF333333)),
                  SizedBox(width: 8.0),
                  Text(
                    'Add',
                    style: TextStyle(
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
