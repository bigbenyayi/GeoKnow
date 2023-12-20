import 'package:geo_know/enum/continent.dart';

extension ContinentExtension on Continent {
  String get readableName {
    switch (this) {
      case Continent.europe:
        return 'Europe';
      case Continent.africa:
        return 'Africa';
      case Continent.asia:
        return 'Asia';
      case Continent.oceania:
        return 'Oceania';
      case Continent.northAmerica:
        return 'North America';
      case Continent.southAmerica:
        return 'South America';
    }
  }

  String get asset {
    switch (this) {
      case Continent.europe:
        return 'assets/images/continents/europe.png';
      case Continent.africa:
        return 'assets/images/continents/africa.png';
      case Continent.asia:
        return 'assets/images/continents/asia.png';
      case Continent.oceania:
        return 'assets/images/continents/oceania.png';
      case Continent.northAmerica:
        return 'assets/images/continents/na.png';
      case Continent.southAmerica:
        return 'assets/images/continents/sa.png';
    }
  }
}