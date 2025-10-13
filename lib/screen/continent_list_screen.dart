import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_know/enum/continent.dart';
import 'package:geo_know/extension/continent_extension.dart';
import 'package:geo_know/screen/country_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContinentListScreen extends StatelessWidget {
  const ContinentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.menu_rounded, color: Theme.of(context).primaryColor),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                }
              ),
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

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  final String _ayoAndroidUrl = 'https://play.google.com/store/apps/details?id=com.ayo.app';
  final String _ayoAppleUrl = 'https://apps.apple.com/us/app/ayo-messaging/id1634626905';

  final String _androidUrl = 'https://play.google.com/store/apps/details?id=com.ayo.geoknow';
  final String _appleUrl = 'https://apps.apple.com/app/id123456789';

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
                  leading: Icon(Icons.link, color: Theme.of(context).primaryColor),
                  title: const Text('Check out Ayo'),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Version 1.0.0',
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