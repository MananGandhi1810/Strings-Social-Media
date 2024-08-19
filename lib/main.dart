import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:strings_social_media/firebase_options.dart';

import 'presentation/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RootApp());
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final Brightness _brightness = Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strings Social Media',
      theme: ThemeData(
        brightness: _brightness,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor:
            _brightness == Brightness.light ? Colors.white : Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor:
                _brightness == Brightness.light ? Colors.white : Colors.black,
            backgroundColor:
                _brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                _brightness == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}
