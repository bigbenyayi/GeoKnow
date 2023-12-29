import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/model/territory.dart';

class Country extends Territory {
  final Continent continent;

  const Country({
    required super.name,
    required super.isoCode,
    required this.continent,
  });

  @override
  String get asset {
    return 'assets/images/country_outlines/$isoCode.png';
  }
}