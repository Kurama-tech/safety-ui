// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_safety/global_bloc.dart';
import 'package:my_safety/provider/Universal.dart';
import 'package:my_safety/provider/counter.dart';

import 'package:my_safety/view/homeView.dart';
import 'package:my_safety/view/musicView.dart';
import 'package:my_safety/view/remindersView.dart';
import 'package:my_safety/view/resourcesView.dart';
import 'package:my_safety/view/safetyPlanView.dart';
import 'package:my_safety/view/splashView.dart';

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
        ChangeNotifierProvider(create: (_) => ContactsPP()),
        ChangeNotifierProvider(create: (_) => Environments()),
        ChangeNotifierProvider(create: (_) => Places()),
        ChangeNotifierProvider(create: (_) => AppointmentsP()),
        ChangeNotifierProvider(create: (_) => MedicationsP()),
      ],
      child: const MyApp(),
    ),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  GlobalBloc globalBloc;

  @override
  void initState() {
    // TODO: implement initState
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
        value: globalBloc,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            initialRoute: '/',
            routes: {
              '/SafetyPlan': (context) => SafetyPlan(),
              '/Reminders': (context) => Reminders(),
              '/Resources': (context) => Resources(),
              '/Music': (context) => MusicView(),
            },
            theme: ThemeData(
              primaryColor: Colors.greenAccent,
              textTheme: TextTheme(headline4: TextStyle(color: Colors.black)),
              appBarTheme:
                  AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
            )));
  }
}
