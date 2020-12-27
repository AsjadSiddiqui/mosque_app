import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainBloc with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  Future<List<String>> getAllCountries() async {
    final countriesSnapshot = (await db.collection('masjid').get()).docs;

    List<String> countryNames = [];

    countriesSnapshot.forEach((country) {
      print(country.id);
      countryNames.add(country.id);
    });

    return countryNames;
  }
}
