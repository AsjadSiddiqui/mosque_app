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

  Future<List<String>> getAllCities(String country) async {
    final citiesSnapshot = (await db.collection('masjid').doc(country).collection('cities').get()).docs;

    List<String> cityNames = [];

    citiesSnapshot.forEach((city) {
      print(city.id);
      cityNames.add(city.id);
    });

    return cityNames;
  }
}
