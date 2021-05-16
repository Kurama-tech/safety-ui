// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety/provider/Universal.dart';
import 'package:safety/provider/counter.dart';
import 'package:safety/view/counterView.dart';
import 'package:safety/view/homeView.dart';
import 'package:ios_platform_images/ios_platform_images.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => UniversalProvider()),
        ChangeNotifierProvider(create: (_) => Warning()),
        ChangeNotifierProvider(create: (_) => Coping()),
        ChangeNotifierProvider(create: (_) => Reasons()),
        ChangeNotifierProvider(create: (_) => Notes()),
        ChangeNotifierProvider(create: (_) => ContactsP()),
        ChangeNotifierProvider(create: (_) => Places()),
      ],
      child: const MyApp(),
    ),
    
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin


class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.black)
        ),
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
      )

    );
  }
}


