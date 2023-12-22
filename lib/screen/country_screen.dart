import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/presentation/custom_app_bar.dart';

class CountryScreen extends StatelessWidget {
  final Country _country;

  const CountryScreen({super.key, required Country country}) : _country = country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _country.name),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: CardSwiper(
              cardsCount: 15,
              padding: const EdgeInsets.only(top: 64.0),
              cardBuilder: (BuildContext context, int index, int x, int y) {
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
                            _country.flag,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                              child: Image.network(
                                'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/e546fb8e-26d3-4684-9c6d-23d723478b44/ui_remover.png?format=1500w',
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'The lines in Kenya are white not like the people' * 7,
                                  style: const TextStyle(color: Color(0xff333333), fontSize: 16.0),
                                  textAlign: TextAlign.center,
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
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: LinearProgressIndicator(
                      value: .9,
                      minHeight: 8.0,
                      color: Colors.grey.shade400,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text('3/10', style: TextStyle(color: Colors.grey.shade400, fontSize: 12.0))
              ],
            ),
          )
        ],
      ),
    );
  }
}
