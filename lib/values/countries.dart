import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/model/country.dart';

class Countries {
  static final List<Country> countries = <Country>[
    const Country(isoCode: 'fr', name: 'France', continent: Continent.europe),
    const Country(isoCode: 'sk', name: 'Slovakia', continent: Continent.europe),
    const Country(isoCode: 'es', name: 'Spain', continent: Continent.europe),
    const Country(isoCode: 'fi', name: 'Finland', continent: Continent.europe),
    const Country(isoCode: 'za', name: 'South Africa', continent: Continent.africa),
  ];
}