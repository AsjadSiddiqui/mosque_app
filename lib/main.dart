import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mosque_app/blocs/mainBloc.dart';
import 'package:mosque_app/pages/cities.dart';
import 'package:provider/provider.dart';

import 'pages/selectCountry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainBloc(),
      builder: (ctx, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          backgroundColor: Color(0xFF303030),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //29dec...
        // home: Welcome(),

        ///

        routes: {
          '/': (ctx) => SelectCountry(),
          '/cities': (ctx) => WelcomeCities(),
        },
      ),
    );
  }
}
