import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/presentation/flashcard.dart';
import 'package:geo_know/presentation/image_error_widget.dart';
import 'package:octo_image/octo_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FlashcardDesign extends StatelessWidget {
  final String _flag;
  final FlashcardContent _flashcard;
  final bool _isFirst;

  const FlashcardDesign({
    super.key,
    required String flag,
    required FlashcardContent flashcard,
    required bool isFirst,
  })  : _flashcard = flashcard,
        _flag = flag,
        _isFirst = isFirst;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flashcard(
        flag: _flag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_flashcard.hasBody || !_isFirst) ...<Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, .0),
                  child: GestureDetector(
                    onTap: () async {
                      if (_flashcard.locationUrl != null) {
                        await launchUrl(Uri.parse(_flashcard.locationUrl!), mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Stack(
                      children: <Widget>[
                        OctoImage(
                          image: CachedNetworkImageProvider(_flashcard.imageUrl),
                          errorBuilder: (BuildContext context, __, ___) => const ImageErrorWidget(),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            color: Colors.black.withValues(alpha: .2),
                            child: const Text('© Data from plonkit.net', style: TextStyle(fontSize: 8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_flashcard.hasBody) ...<Widget>[
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
            ] else ...<Widget>[
              Container(
                color: Colors.black.withValues(alpha: .2),
                child: const Text('© Data from plonkit.net', style: TextStyle(fontSize: 8)),
              ),
              ...List<Widget>.generate(4, (int index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (_flashcard.locationUrl != null) {
                          await launchUrl(
                            Uri.parse(_flashcard.locationUrl!),
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.25, // always show 1/4 of the width
                          child: FractionalTranslation(
                            translation: Offset(-index * 0.25, 0), // shift left by n quarters
                            child: OctoImage(
                              image: CachedNetworkImageProvider(_flashcard.imageUrl),
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, __, ___) => const ImageErrorWidget(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ]
          ],
        ),
      ),
    );
  }
}