// ignore_for_file: missing_whitespace_between_adjacent_strings
import 'package:geo_know/model/flashcard_content.dart';
import 'package:geo_know/model/territory.dart';


class Territories {
  static final List<Territory> territories = <Territory>[
    const Territory(isoCode: 'us-al', name: 'Alaska'),
    const Territory(isoCode: 'us-hi', name: 'Hawaii'),
    const Territory(isoCode: 'us', name: 'Contiguous US'),
    const Territory(isoCode: 'vi', name: 'Virgin Islands'),
    const Territory(isoCode: 'pr', name: 'Puerto Rico'),
  ];
}