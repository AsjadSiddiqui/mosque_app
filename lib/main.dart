import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/main_bloc.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/select_cities.dart';
import 'pages/select_country.dart';
import 'pages/select_masjid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBloc>(
      create: (BuildContext context) => MainBloc(),
      builder: (BuildContext ctx, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF303030),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, Widget Function(BuildContext)>{
          // '/': (BuildContext ctx) => const Login(),
          // '/countries': (BuildContext ctx) => const SelectCountry(),
          '/': (BuildContext ctx) => const SelectCountry(),
          '/login': (BuildContext ctx) => const Login(),
          '/register': (BuildContext ctx) => const Register(),
          '/cities': (BuildContext ctx) => const WelcomeCities(),
          '/masjids': (BuildContext ctx) => const SelectMasjid(),
          '/home': (BuildContext ctx) => const Home(),
        },
      ),
    );
  }
}
