import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/presentation/flashcard.dart';
import 'package:geo_know/presentation/image_error_widget.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/url_launcher.dart';


class FlashcardDesign extends StatelessWidget {
  final String _flag;
  final FlashcardContent _flashcard;

  const FlashcardDesign({
    super.key,
    required String flag,
    required FlashcardContent flashcard,
  })  : _flashcard = flashcard,
        _flag = flag;

  @override
  Widget build(BuildContext context) {
    return Flashcard(
      flag: _flag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, .0),
              child: GestureDetector(
                onTap: () async {
                  if (_flashcard.locationUrl != null) {
                    await launchUrl(Uri.parse(_flashcard.locationUrl!), mode: LaunchMode.externalApplication);
                  }
                },
                child: OctoImage(
                  image: CachedNetworkImageProvider(_flashcard.imageUrl),
                  errorBuilder: (BuildContext context, __, ___) => const ImageErrorWidget(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  _flashcard.body,
                  textStyle: const TextStyle(color: Color(0xff333333), fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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