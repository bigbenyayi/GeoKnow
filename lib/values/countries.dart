import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/model/country.dart';

enum CountryEnum {
  // Africa
  bw('bw', 'Botswana', Continent.africa),
  eg('eg', 'Egypt', Continent.africa),
  sz('sz', 'Eswatini', Continent.africa),
  gh('gh', 'Ghana', Continent.africa),
  ke('ke', 'Kenya', Continent.africa),
  ls('ls', 'Lesotho', Continent.africa),
  mg('mg', 'Madagascar', Continent.africa),
  ml('ml', 'Mali', Continent.africa),
  na('na', 'Namibia', Continent.africa),
  ng('ng', 'Nigeria', Continent.africa),
  re('re', 'Réunion', Continent.africa),
  rw('rw', 'Rwanda', Continent.africa),
  sn('sn', 'Senegal', Continent.africa),
  za('za', 'South Africa', Continent.africa),
  st('st', 'São Tomé', Continent.africa),
  tz('tz', 'Tanzania', Continent.africa),
  tn('tn', 'Tunisia', Continent.africa),
  ug('ug', 'Uganda', Continent.africa),

  // Asia
  bd('bd', 'Bangladesh', Continent.asia),
  bt('bt', 'Bhutan', Continent.asia),
  io('io', 'British Indian Ocean Territory', Continent.asia),
  kh('kh', 'Cambodia', Continent.asia),
  cn('cn', 'China', Continent.asia),
  hk('hk', 'Hong Kong', Continent.asia),
  in_('in', 'India', Continent.asia), // 'in' is reserved, so use in_
  id('id', 'Indonesia', Continent.asia),
  iq('iq', 'Iraq', Continent.asia),
  jp('jp', 'Japan', Continent.asia),
  il('il', 'Israel', Continent.asia),
  jo('jo', 'Jordan', Continent.asia),
  kz('kz', 'Kazakhstan', Continent.asia),
  kg('kg', 'Kyrgyzstan', Continent.asia),
  la('la', 'Laos', Continent.asia),
  lb('lb', 'Lebanon', Continent.asia),
  mo('mo', 'Macau', Continent.asia),
  my('my', 'Malaysia', Continent.asia),
  mn('mn', 'Mongolia', Continent.asia),
  np('np', 'Nepal', Continent.asia),
  om('om', 'Oman', Continent.asia),
  pk('pk', 'Pakistan', Continent.asia),
  ph('ph', 'Philippines', Continent.asia),
  qa('qa', 'Qatar', Continent.asia),
  ru('ru', 'Russia', Continent.asia),
  sg('sg', 'Singapore', Continent.asia),
  kr('kr', 'South Korea', Continent.asia),
  lk('lk', 'Sri Lanka', Continent.asia),
  tw('tw', 'Taiwan', Continent.asia),
  th('th', 'Thailand', Continent.asia),
  tr('tr', 'Turkey', Continent.asia),
  ae('ae', 'U.A.E', Continent.asia),

  // Europe
  al('al', 'Albania', Continent.europe),
  ad('ad', 'Andorra', Continent.europe),
  at('at', 'Austria', Continent.europe),
  by('by', 'Belarus', Continent.europe),
  be('be', 'Belgium', Continent.europe),
  bg('bg', 'Bulgaria', Continent.europe),
  hr('hr', 'Croatia', Continent.europe),
  cy('cy', 'Cyprus', Continent.europe),
  cz('cz', 'Czechia', Continent.europe),
  dk('dk', 'Denmark', Continent.europe),
  ee('ee', 'Estonia', Continent.europe),
  fo('fo', 'Faroe Islands', Continent.europe),
  fi('fi', 'Finland', Continent.europe),
  fr('fr', 'France', Continent.europe),
  de('de', 'Germany', Continent.europe),
  gi('gi', 'Gibraltar', Continent.europe),
  gr('gr', 'Greece', Continent.europe),
  hu('hu', 'Hungary', Continent.europe),
  is_('is', 'Iceland', Continent.europe), // 'is' reserved, so is_
  ie('ie', 'Ireland', Continent.europe),
  it('it', 'Italy', Continent.europe),
  im('im', 'Isle of Man', Continent.europe),
  lv('lv', 'Latvia', Continent.europe),
  li('li', 'Liechtenstein', Continent.europe),
  lt('lt', 'Lithuania', Continent.europe),
  lu('lu', 'Luxembourg', Continent.europe),
  mt('mt', 'Malta', Continent.europe),
  mc('mc', 'Monaco', Continent.europe),
  me('me', 'Montenegro', Continent.europe),
  nl('nl', 'Netherlands', Continent.europe),
  mk('mk', 'North Macedonia', Continent.europe),
  no('no', 'Norway', Continent.europe),
  pl('pl', 'Poland', Continent.europe),
  pt('pt', 'Portugal', Continent.europe),
  ro('ro', 'Romania', Continent.europe),
  sm('sm', 'San Marino', Continent.europe),
  rs('rs', 'Serbia', Continent.europe),
  sk('sk', 'Slovakia', Continent.europe),
  si('si', 'Slovenia', Continent.europe),
  es('es', 'Spain', Continent.europe),
  sj('sj', 'Svalbard', Continent.europe),
  se('se', 'Sweden', Continent.europe),
  ch('ch', 'Switzerland', Continent.europe),
  ua('ua', 'Ukraine', Continent.europe),
  gb('gb', 'United Kingdom', Continent.europe),

  // North America
  bm('bm', 'Bermuda', Continent.northAmerica),
  ca('ca', 'Canada', Continent.northAmerica),
  cr('cr', 'Costa Rica', Continent.northAmerica),
  do_('do', 'Dominican Republic', Continent.northAmerica), // 'do' reserved
  gl('gl', 'Greenland', Continent.northAmerica),
  gt('gt', 'Guatemala', Continent.northAmerica),
  mq('mq', 'Martinique', Continent.northAmerica),
  mx('mx', 'Mexico', Continent.northAmerica),
  pa('pa', 'Panama', Continent.northAmerica),
  pm('pm', 'Saint Pierre and Miquelon', Continent.northAmerica),
  us('us', 'United States', Continent.northAmerica),

  // Oceania
  as_('as', 'American Samoa', Continent.oceania),
  au('au', 'Australia', Continent.oceania),
  cx('cx', 'Christmas Island', Continent.oceania),
  cc('cc', 'Cocos Islands', Continent.oceania),
  gu('gu', 'Guam', Continent.oceania),
  nz('nz', 'New Zealand', Continent.oceania),
  mp('mp', 'Northern Mariana Islands', Continent.oceania),
  pn('pn', 'Pitcairn Islands', Continent.oceania),
  vu('vu', 'Vanuatu', Continent.oceania),

  // South America
  ar('ar', 'Argentina', Continent.southAmerica),
  bo('bo', 'Bolivia', Continent.southAmerica),
  br('br', 'Brazil', Continent.southAmerica),
  cl('cl', 'Chile', Continent.southAmerica),
  co('co', 'Colombia', Continent.southAmerica),
  cw('cw', 'Curacao', Continent.southAmerica),
  ec('ec', 'Ecuador', Continent.southAmerica),
  fk('fk', 'Falkland Islands', Continent.southAmerica),
  pe('pe', 'Peru', Continent.southAmerica),
  uy('uy', 'Uruguay', Continent.southAmerica),

  // Antarctica
  aq('aq', 'Antarctica', Continent.antarctica),
  gs('gs', 'South Georgia', Continent.antarctica);

  final String isoCode;
  final String name;
  final Continent continent;

  const CountryEnum(this.isoCode, this.name, this.continent);

  static List<Country> getCountries(Continent continent) {
    return CountryEnum.values
        .where((CountryEnum country) => country.continent == continent)
        .map((CountryEnum country) => Country(name: country.name, isoCode: country.isoCode, continent: country.continent))
        .toList();
  }

  Country get toCountry {
    return Country(name: name, isoCode: isoCode, continent: continent);
  }

  static CountryEnum fromIsoCode(String isoCode) {
    return CountryEnum.values.firstWhere((CountryEnum country) => country.isoCode == isoCode);
  }
}