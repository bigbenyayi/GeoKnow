import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/values/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetJsonUtil {
  static Future<List<FlashcardContent>> loadFlashcards({required String countryCode}) async {
    final String jsonString = await rootBundle.loadString('assets/data/$countryCode.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<FlashcardContent> flashcards =
        jsonList.map((dynamic json) => FlashcardContent.fromJson(json, countryCode)).toList();
    final List<int> countryValues = await SharedPrefsHelper.getCountryValues(countryCode);

    final List<FlashcardContent> result = <FlashcardContent>[...flashcards];
    for (int i = 0; i < flashcards.length; i++) {
      result[i] = result[i].copyWith(isFavorite: countryValues.contains(i));
    }
    return result;
  }
}

class SharedPrefsHelper {
  static const String _prefix = 'country_data_';

  /// Save a list of integers for a given ISO country code.
  static Future<void> saveCountryValues(String isoCode, List<int> values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = '$_prefix$isoCode';
    final List<String> stringList = values.map((int e) => e.toString()).toList();
    await prefs.setStringList(key, stringList);
  }

  /// Read the stored integer list for a given ISO country code.
  static Future<List<int>> getCountryValues(String isoCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String key = '$_prefix$isoCode';
    final List<String>? stringList = prefs.getStringList(key);
    if (stringList == null) {
      return <int>[];
    }
    return stringList.map(int.parse).toList();
  }

  /// Add a single integer to the list for a given ISO code (no duplicates).
  static Future<void> addCountryValue(String isoCode, int value) async {
    final List<int> currentValues = await getCountryValues(isoCode);
    if (!currentValues.contains(value)) {
      currentValues.add(value);
      await saveCountryValues(isoCode, currentValues);
    }
  }

  /// Remove a single integer from a country’s list.
  static Future<void> removeCountryValue(String isoCode, int value) async {
    final List<int> currentValues = await getCountryValues(isoCode);
    currentValues.remove(value);
    await saveCountryValues(isoCode, currentValues);
  }

  /// Remove a favorite by its global index across *all* countries.
  ///
  /// Example:
  ///   If you have:
  ///     { "jo": [0, 2], "za": [1, 5, 6] }
  ///   Then global favorites = [("jo",0), ("jo",2), ("za",1), ("za",5), ("za",6)]
  ///   Calling removeGlobalFavorite(3) removes ("za",5)
  static Future<void> removeGlobalFavorite(int globalIndex) async {
    final Map<String, List<int>> allFavorites = await getAllFavorites();

    // Expand to a flat list of pairs (isoCode, index)
    final List<MapEntry<String, int>> flatList = allFavorites.entries
        .expand((MapEntry<String, List<int>> entry) => entry.value.map((int i) => MapEntry(entry.key, i)))
        .toList();

    if (globalIndex < 0 || globalIndex >= flatList.length) {
      return;
    }

    // Identify the country and index to remove
    final String isoCode = flatList[globalIndex].key;
    final int localIndex = flatList[globalIndex].value;

    // Remove from that country's stored list
    await removeCountryValue(isoCode, localIndex);
  }

  /// Clear all data for one country.
  static Future<void> clearCountryData(String isoCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$isoCode');
  }

  /// Clear all country-related data.
  static Future<void> clearAllCountryData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Iterable<String> keys = prefs.getKeys().where((String key) => key.startsWith(_prefix));
    for (final String key in keys) {
      await prefs.remove(key);
    }
  }

  // ---------------------------------------------------------------------------
  // 🔥 NEW: Fetch favorites
  // ---------------------------------------------------------------------------

  /// Get all saved country data as a map: `{ "jo": [0, 2, 156], "za": [1, 5] }`
  static Future<Map<String, List<int>>> getAllFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, List<int>> result = <String, List<int>>{};
    for (final String key in prefs.getKeys()) {
      if (key.startsWith(_prefix)) {
        final String isoCode = key.replaceFirst(_prefix, '');
        final List<String>? stringList = prefs.getStringList(key);
        if (stringList != null && stringList.isNotEmpty) {
          result[isoCode] = stringList.map(int.parse).toList();
        }
      }
    }
    return result;
  }

  /// Get all favorites grouped by continent.
  ///
  /// Example result:
  /// ```
  /// {
  ///   Continent.asia: ["jo", "jp"],
  ///   Continent.africa: ["za"]
  /// }
  /// ```
  static Future<Map<Continent, List<String>>> getFavoritesByContinent() async {
    final Map<String, List<int>> allFavs = await getAllFavorites();
    final Map<Continent, List<String>> grouped = <Continent, List<String>>{};

    for (final String iso in allFavs.keys) {
      final CountryEnum? country = CountryEnum.values.firstWhereOrNull((CountryEnum c) => c.isoCode == iso);
      if (country != null) {
        grouped.putIfAbsent(country.continent, () => <String>[]).add(iso);
      }
    }

    return grouped;
  }

  static Future<List<FlashcardContent>> loadAllFavoriteFlashcards() async {
    final Map<String, List<int>> allFavorites = await SharedPrefsHelper.getAllFavorites();

    final List<FlashcardContent> favorites = <FlashcardContent>[];

    for (final String isoCode in allFavorites.keys) {
      // Load the full flashcard list for this country
      final String jsonString = await rootBundle.loadString('assets/data/$isoCode.json');
      final List<dynamic> jsonList = jsonDecode(jsonString);

      final List<FlashcardContent> flashcards =
          jsonList.map((dynamic json) => FlashcardContent.fromJson(json, isoCode)).toList();

      // Keep only the favorited ones
      for (final int index in allFavorites[isoCode]!) {
        if (index >= 0 && index < flashcards.length) {
          favorites.add(
            flashcards[index].copyWith(isFavorite: true, isoCode: isoCode),
          );
        }
      }
    }

    return favorites;
  }
}
