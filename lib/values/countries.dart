// ignore_for_file: missing_whitespace_between_adjacent_strings

import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/model/flashcard_content.dart';

class Countries {
  static final Map<String, List<FlashcardContent>> flashcardContent = <String, List<FlashcardContent>>{
    'kh': const <FlashcardContent>[
      FlashcardContent(
        image: 'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/a2809755-3666-40c6-a708-f7f7db9440dd/summary_cambo.png?format=2500w',
        text: 'The colours of the flag are <b>blue</b> and <b>red</b>.<br><br>'
            'The country domain code is <b>.kh</b>.<br><br>'
            'Driving on the <b>right</b> side of the road.<br><br>'
            '80% of the camera coverage is <b>Gen 1.</b>',
      ),
      FlashcardContent(
        image: 'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/5877fda9-6bb7-475b-bf8b-79aaa2d8d632/Cambodia+License+Plate.png?format=1500w',
        text: 'Licence plates are <b>white</b> with <b>blue</b> letters.<br><br>'
            'Plates on government vehicles are <b>green</b>.',
      ),
      FlashcardContent(
        image: 'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/7deef731-cc75-4485-b37d-3418af4efe0a/Cambodia+cars+large.png?format=1500w',
        text: 'Generation 3 coverage:<br><br>'
            '• short stubby antenna with <b>3 ridges</b><br><br>'
            '• a white car with <b>stripes</b> and <b>no antenna</b> (white stripe on the left, yellow on the right)'
      ),
      FlashcardContent(
        image: 'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/419c5627-2eec-495d-8ee3-657955d4dda4/Khmer.png?format=1500w',
        text: 'The official language is <b>Khmer</b>.'
      ),
      FlashcardContent(
        image: 'https://images.squarespace-cdn.com/content/v1/60f6054f4e76b03092956de8/f16ffa9d-a88d-4f3c-b5d9-13a584d89126/Cambodia+poles.png?format=1500w',
        text: 'Two types of poles are common:<br><br>'
            '• concrete <b>ladder</b> poles.<br><br>'
            '• round concrete poles with small <b>holes</b>.'
      ),
    ],
  };
  static final List<Country> countries = <Country>[
    const Country(isoCode: 'bw', name: 'Botswana', continent: Continent.africa),
    const Country(isoCode: 'eg', name: 'Egypt', continent: Continent.africa),
    const Country(isoCode: 'sz', name: 'Eswatini', continent: Continent.africa),
    const Country(isoCode: 'gh', name: 'Ghana', continent: Continent.africa),
    const Country(isoCode: 'ke', name: 'Kenya', continent: Continent.africa),
    const Country(isoCode: 'ls', name: 'Lesotho', continent: Continent.africa),
    const Country(isoCode: 'mg', name: 'Madagascar', continent: Continent.africa),
    const Country(isoCode: 'ml', name: 'Mali', continent: Continent.africa),
    const Country(isoCode: 're', name: 'Réunion', continent: Continent.africa),
    const Country(isoCode: 'rw', name: 'Rwanda', continent: Continent.africa),
    const Country(isoCode: 'sn', name: 'Senegal', continent: Continent.africa),
    const Country(isoCode: 'za', name: 'South Africa', continent: Continent.africa),
    const Country(isoCode: 'tn', name: 'Tunisia', continent: Continent.africa),
    const Country(isoCode: 'ug', name: 'Uganda', continent: Continent.africa),
    const Country(isoCode: 'bd', name: 'Bangladesh', continent: Continent.asia),
    const Country(isoCode: 'bt', name: 'Bhutan', continent: Continent.asia),
    const Country(isoCode: 'kh', name: 'Cambodia', continent: Continent.asia),
    const Country(isoCode: 'hk', name: 'Hong Kong', continent: Continent.asia),
    const Country(isoCode: 'id', name: 'Indonesia', continent: Continent.asia),
    const Country(isoCode: 'il', name: 'Israel', continent: Continent.asia),
    const Country(isoCode: 'jo', name: 'Jordan', continent: Continent.asia),
    const Country(isoCode: 'kg', name: 'Kyrgyzstan', continent: Continent.asia),
    const Country(isoCode: 'la', name: 'Laos', continent: Continent.asia),
    const Country(isoCode: 'my', name: 'Malaysia', continent: Continent.asia),
    const Country(isoCode: 'qa', name: 'Qatar', continent: Continent.asia),
    const Country(isoCode: 'sg', name: 'Singapore', continent: Continent.asia),
    const Country(isoCode: 'kr', name: 'South Korea', continent: Continent.asia),
    const Country(isoCode: 'lk', name: 'Sri Lanka', continent: Continent.asia),
    const Country(isoCode: 'tw', name: 'Taiwan', continent: Continent.asia),
    const Country(isoCode: 'th', name: 'Thailand', continent: Continent.asia),
    const Country(isoCode: 'ae', name: 'U.A.E', continent: Continent.asia),
    const Country(isoCode: 'al', name: 'Albania', continent: Continent.europe),
    const Country(isoCode: 'ad', name: 'Andorra', continent: Continent.europe),
    const Country(isoCode: 'at', name: 'Austria', continent: Continent.europe),
    const Country(isoCode: 'by', name: 'Belarus', continent: Continent.europe),
    const Country(isoCode: 'be', name: 'Belgium', continent: Continent.europe),
    const Country(isoCode: 'hr', name: 'Croatia', continent: Continent.europe),
    const Country(isoCode: 'cz', name: 'Czechia', continent: Continent.europe),
    const Country(isoCode: 'dk', name: 'Denmark', continent: Continent.europe),
    const Country(isoCode: 'ee', name: 'Estonia', continent: Continent.europe),
    const Country(isoCode: 'fo', name: 'Faroe Islands', continent: Continent.europe),
    const Country(isoCode: 'fi', name: 'Finland', continent: Continent.europe),
    const Country(isoCode: 'de', name: 'Germany', continent: Continent.europe),
    const Country(isoCode: 'gi', name: 'Gibraltar', continent: Continent.europe),
    const Country(isoCode: 'gr', name: 'Greece', continent: Continent.europe),
    const Country(isoCode: 'hu', name: 'Hungary', continent: Continent.europe),
    const Country(isoCode: 'is', name: 'Iceland', continent: Continent.europe),
    const Country(isoCode: 'ie', name: 'Ireland', continent: Continent.europe),
    const Country(isoCode: 'it', name: 'Italy', continent: Continent.europe),
    const Country(isoCode: 'im', name: 'Isle of Man', continent: Continent.europe),
    const Country(isoCode: 'lv', name: 'Latvia', continent: Continent.europe),
    const Country(isoCode: 'lt', name: 'Lithuania', continent: Continent.europe),
    const Country(isoCode: 'lu', name: 'Luxembourg', continent: Continent.europe),
    const Country(isoCode: 'mt', name: 'Malta', continent: Continent.europe),
    const Country(isoCode: 'mc', name: 'Monaco', continent: Continent.europe),
    const Country(isoCode: 'me', name: 'Montenegro', continent: Continent.europe),
    const Country(isoCode: 'nl', name: 'Netherlands', continent: Continent.europe),
    const Country(isoCode: 'mk', name: 'North Macedonia', continent: Continent.europe),
    const Country(isoCode: 'no', name: 'Norway', continent: Continent.europe),
    const Country(isoCode: 'pl', name: 'Poland', continent: Continent.europe),
    const Country(isoCode: 'ro', name: 'Romania', continent: Continent.europe),
    const Country(isoCode: 'sm', name: 'San Marino', continent: Continent.europe),
    const Country(isoCode: 'rs', name: 'Serbia', continent: Continent.europe),
    const Country(isoCode: 'sk', name: 'Slovakia', continent: Continent.europe),
    const Country(isoCode: 'si', name: 'Slovenia', continent: Continent.europe),
    const Country(isoCode: 'es', name: 'Spain', continent: Continent.europe),
    const Country(isoCode: 'sj', name: 'Svalbard', continent: Continent.europe),
    const Country(isoCode: 'se', name: 'Sweden', continent: Continent.europe),
    const Country(isoCode: 'ch', name: 'Switzerland', continent: Continent.europe),
    const Country(isoCode: 'ua', name: 'Ukraine', continent: Continent.europe),
    const Country(isoCode: 'gb', name: 'United Kingdom', continent: Continent.europe),
    const Country(isoCode: 'bm', name: 'Bermuda', continent: Continent.northAmerica),
    const Country(isoCode: 'ca', name: 'Canada', continent: Continent.northAmerica),
    const Country(isoCode: 'do', name: 'Dominican Republic', continent: Continent.northAmerica),
    const Country(isoCode: 'gl', name: 'Greenland', continent: Continent.northAmerica),
    const Country(isoCode: 'gt', name: 'Guatemala', continent: Continent.northAmerica),
    const Country(isoCode: 'pr', name: 'Puerto Rico', continent: Continent.northAmerica),
    const Country(isoCode: 'us', name: 'United States', continent: Continent.northAmerica),
    const Country(isoCode: 'as', name: 'American Samoa', continent: Continent.oceania),
    const Country(isoCode: 'au', name: 'Australia', continent: Continent.oceania),
    const Country(isoCode: 'cx', name: 'Christmas Island', continent: Continent.oceania),
    const Country(isoCode: 'gu', name: 'Guam', continent: Continent.oceania),
    const Country(isoCode: 'nz', name: 'New Zealand', continent: Continent.oceania),
    const Country(isoCode: 'ar', name: 'Argentina', continent: Continent.southAmerica),
    const Country(isoCode: 'br', name: 'Brazil', continent: Continent.southAmerica),
    const Country(isoCode: 'cl', name: 'Chile', continent: Continent.southAmerica),
    const Country(isoCode: 'co', name: 'Colombia', continent: Continent.southAmerica),
    const Country(isoCode: 'cw', name: 'Curacao', continent: Continent.southAmerica),
    const Country(isoCode: 'ec', name: 'Ecuador', continent: Continent.southAmerica),
    const Country(isoCode: 'uy', name: 'Uruguay', continent: Continent.southAmerica),
  ];
}
