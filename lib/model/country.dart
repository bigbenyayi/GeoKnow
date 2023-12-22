import 'package:geo_know/enum/continent.dart';

class Country {
  final String isoCode;
  final String name;
  final Continent continent;

  const Country({
    required this.isoCode,
    required this.name,
    required this.continent,
  });

  String get asset {
    return 'assets/images/country_outlines/$isoCode.png';
  }

  String get flag {
    return 'assets/images/flags/$isoCode.svg';
  }
}