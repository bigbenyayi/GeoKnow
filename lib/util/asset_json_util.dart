import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:geo_know/model/flashcard_content.dart';

class AssetJsonUtil {
  static Future<List<FlashcardContent>> loadFlashcards({required String countryCode}) async {
    final String jsonString = await rootBundle.loadString('assets/data/$countryCode.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => FlashcardContent.fromJson(json)).toList();
  }
}
