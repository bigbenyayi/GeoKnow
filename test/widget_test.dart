import 'package:blurhash_dart/blurhash_dart.dart' as hash;
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/values/countries.dart';
import 'package:geo_know/values/territories.dart';
import 'package:http/http.dart';
import 'package:image/image.dart';

// void main() async {
//   test('Country hash generation', () async {
//     await _generateHashes(Countries.flashcardContent);
//   });
//
//   test('Territory hash generation', () async {
//     await _generateHashes(Territories.flashcardContent);
//   });
// }
//
// Future<void> _generateHashes(Map<String, List<FlashcardContent>> flashcardContent) async {
//   String result = '';
//   for (final MapEntry<String, List<FlashcardContent>> entry in flashcardContent.entries) {
//     // if (entry.key != 'za' || entry.key != 'fr') {
//     //   continue;
//     // }
//     for (final FlashcardContent content in entry.value) {
//       result += "blurHash: '${await _generateBlurHash(content.image)}',\n";
//     }
//   }
//   debugPrint(result);
// }
//
// Future<String> _generateBlurHash(String url) async {
//   final Response response = await get(Uri.parse(url));
//   final Image? image = decodeImage(response.bodyBytes);
//   final hash.BlurHash blurHash = hash.BlurHash.encode(image!);
//   return blurHash.hash.replaceAll(r'$', r'\$');
// }
