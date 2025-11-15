import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/model/country.dart';
import 'package:geo_know/presentation/territory_card.dart';
import 'package:geo_know/screen/country_list_screen.dart';
import 'package:geo_know/screen/quiz_list_screen.dart';
import 'package:geo_know/values/countries.dart';
import 'package:url_launcher/url_launcher.dart';

class ContinentListScreen extends StatefulWidget {
  const ContinentListScreen({super.key});

  @override
  State<ContinentListScreen> createState() => _ContinentListScreenState();
}

class _ContinentListScreenState extends State<ContinentListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu_rounded, color: Theme.of(context).primaryColor),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              }),
              title: Transform.translate(
                offset: const Offset(-20.0, 0.0),
                child: Text(
                  'GeoKnow',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 50.0,
                  ),
                ),
              ),
              scrolledUnderElevation: .0,
            ),
            ModernRoundedSearchField(controller: _controller),
            _SearchGridView(controller: _controller),
            ListView.builder(
              itemCount: Continent.values.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16.0),
              itemBuilder: (BuildContext context, int index) {
                final Continent continent = Continent.values[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return CountryListScreen(continent: continent);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black26, blurRadius: 4.0, spreadRadius: .5, offset: Offset(0, 3))
                        ]),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            continent.readableName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Image>[
                              Image.asset(
                                continent.asset,
                                color: Colors.grey.shade300,
                                height: 100,
                                width: 100,
                              ),
                              Image.asset(
                                continent.asset,
                                width: 97,
                                height: 97,
                                color: const Color(0xFF86a298),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchGridView extends StatefulWidget {
  final TextEditingController _controller;

  const _SearchGridView({
    required TextEditingController controller,
  }) : _controller = controller;

  @override
  State<_SearchGridView> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<_SearchGridView> {
  List<CountryEnum> _filteredCountries = <CountryEnum>[];

  @override
  Widget build(BuildContext context) {
    if (_filteredCountries.isEmpty) {
      return const SizedBox();
    }
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredCountries.length,
      itemBuilder: (BuildContext context, int index) {
        final Country country = _filteredCountries[index].toCountry;
        return TerritoryCard(territory: country);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() {
      _filterCountries();
    });
  }

  void _filterCountries() {
    if (widget._controller.text.isEmpty) {
      setState(() {
        _filteredCountries = <CountryEnum>[];
      });
      return;
    }
    final String searchLower = widget._controller.text.toLowerCase();
    final List<CountryEnum> results = CountryEnum.values.where((CountryEnum country) {
      final String countryNameLower = country.name.toLowerCase();
      return countryNameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredCountries = results;
    });
  }
}

class ModernRoundedSearchField extends StatefulWidget {
  final TextEditingController _controller;

  const ModernRoundedSearchField({super.key, required TextEditingController controller})
      : _controller = controller;

  @override
  State<ModernRoundedSearchField> createState() => _ModernRoundedSearchFieldState();
}

class _ModernRoundedSearchFieldState extends State<ModernRoundedSearchField> {
  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 4.0, spreadRadius: .5, offset: Offset(0, 3))
          ],
        ),
        child: TextField(
          controller: widget._controller,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            hintText: 'Search a country',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: widget._controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      widget._controller.clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          ),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  final String _ayoAndroidUrl = 'https://play.google.com/store/apps/details?id=com.ayo.app';
  final String _ayoAppleUrl = 'https://apps.apple.com/us/app/ayo-messaging/id1634626905';

  final String _androidUrl = 'https://play.google.com/store/apps/details?id=com.ayo.geo_know';
  final String _appleUrl = 'https://apps.apple.com/us/app/geoknow/id6753939511';

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openAppStore({required String playStore, required String appStore}) {
    if (Platform.isAndroid) {
      _launchUrl(playStore);
    } else if (Platform.isIOS) {
      _launchUrl(appStore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'GeoKnow',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.emoji_objects, color: Theme.of(context).primaryColor),
                title: const Text('Quiz yourself'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const QuizListScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Platform.isAndroid ? Icons.apps : Icons.link, color: Theme.of(context).primaryColor),
                title: Text(Platform.isAndroid ? 'More apps from me' : 'Check out Ayo'),
                onTap: () {
                  _openAppStore(playStore: _ayoAndroidUrl, appStore: _ayoAppleUrl);
                },
              ),
              ListTile(
                leading: Icon(Icons.star_rate, color: Theme.of(context).primaryColor),
                title: const Text('Rate Us'),
                onTap: () {
                  _openAppStore(playStore: _androidUrl, appStore: _appleUrl);
                },
              ),
            ],
          ),
          // Footer section with version info
          const Spacer(),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse('https://www.buymeacoffee.com/bigbenyayi'), mode: LaunchMode.externalApplication);
            },
            child: Image.asset('assets/images/buy_me_a_coffee.png', width: 150),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.6',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
