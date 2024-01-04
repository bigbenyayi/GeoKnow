import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/presentation/image_error_widget.dart';
import 'package:geo_know/presentation/image_placeholder.dart';
import 'package:octo_image/octo_image.dart';


class FlashcardDesign extends StatelessWidget {
  final String flag;
  final FlashcardContent flashcard;

  const FlashcardDesign({super.key, required this.flag, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 516.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 16.0, spreadRadius: 4, offset: Offset(0, 3)),
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
                flag,
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
                    child: OctoImage(
                      image: CachedNetworkImageProvider(flashcard.image),
                      placeholderBuilder: (BuildContext context) {
                        return blurHashPlaceholderBuilder(flashcard.blurHash, fit: BoxFit.contain);
                      },
                      errorBuilder: (BuildContext context, __, ___) => const ImageErrorWidget(),
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
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('flag', flag))
    ..add(DiagnosticsProperty<FlashcardContent>('flashcard', flashcard));
  }

  Widget blurHashPlaceholderBuilder(
    String hash, {
    BoxFit? fit,
    Text? message,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
  }) {
    return SizedBox.expand(
      child: Image(
        image: BlurHashImage(hash),
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}