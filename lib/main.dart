import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:geo_know/firebase_options.dart';
import 'package:geo_know/screen/continent_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable automatic Crashlytics error collection
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Capture async errors (outside Flutter framework)
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Prompt',
        colorScheme: ColorScheme.fromSeed(primary: const Color(0xFF004830), seedColor: const Color(0xFF004830)),
        useMaterial3: true,
      ),
      home: const ContinentListScreen(),
    );
  }
}