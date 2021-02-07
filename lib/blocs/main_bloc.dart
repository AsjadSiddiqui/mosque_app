import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class MainBloc with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  bool gotUserDetails = false;
  User currUser;
  String userUID;
  String userEmail;
  String firstName;
  String lastName;
  String userProfilePicURL;

  // SharedPreferences prefs;
  Box<dynamic> box;

  bool hasInitPrefs = false;

  String city;
  String country;
  String masjidName;
  String masjidImageURL;
  String masjidAddress;
  String masjidNameArabic;

  // Future<void> initPrefs() async {
  //   if (hasInitPrefs) {
  //     return;
  //   }
  //   prefs = await SharedPreferences.getInstance();
  //   hasInitPrefs = true;
  // }

  Future<void> showToast(String msg) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> showToastLong(String msg) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> createUserFirestore() async {
    await db.collection('users').doc(userUID).set(
      <String, dynamic>{
        'uid': userUID,
        'time': DateTime.now(),
        'firstName': firstName,
        'lastName': lastName,
        'email': userEmail,
        'profilePic': userProfilePicURL,
        'lastUpdated': DateTime.now(),
      },
    );
  }

  Future<void> updateFirebase() async {
    await db.collection('users').doc(userUID).update(
      <String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'email': userEmail,
        'profilePic': userProfilePicURL,
        'lastUpdated': DateTime.now(),
      },
    );
  }

  Future<String> registerNewUser({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user.uid);
      userUID = userCredential.user.uid.toString();
      isLoggedIn = true;
      this.firstName = firstName;
      this.lastName = lastName;
      userEmail = email;
      currUser = userCredential.user;
      await createUserFirestore();
      // await db
      //     .collection('registeredUsernames')
      //     .doc(userName)
      //     .set(<String, String>{
      //   'name': userName,
      // });
      print('Created User...');
      gotUserDetails = true;

      return 'ok';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'Account already exists for that email';
      } else {
        print(e.toString());
        return e.code;
      }
    } catch (e) {
      print(e);
      return 'Check your internet connection and try again';
    }
  }

  Future<void> getUserDetailsFirebase() async {
    print('Getting User Data..... !');
    // userUID = currUser.uid;
    final snapshot = await db.collection('users').doc(userUID).get();
    final data = snapshot.data();
    print('Data here:');
    print(data);
    firstName = data['firstName'] as String;
    lastName = data['lastName'] as String;
    userProfilePicURL = data['profilePic'] as String;
    userEmail = data['email'] as String;
    gotUserDetails = true;
    notifyListeners();
  }

  Future<String> signInUser({
    @required String email,
    @required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user.uid);
      userUID = userCredential.user.uid.toString();
      isLoggedIn = true;
      userEmail = email;
      currUser = userCredential.user;
      await getUserDetailsFirebase();
      return 'ok';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        return 'Wrong email or password';
      } else {
        print(e.toString());
        return e.code;
      }
    } catch (e) {
      print(e);
      return 'Check your internet connection and try again';
    }
  }

  void getAllData() {
    city = read('city') as String;
    country = read('country') as String;
    masjidName = read('masjid') as String;
    masjidNameArabic = read('nameArabic') as String;

    masjidImageURL = read('masjidImageURL') as String;
    masjidAddress = read('masjidAddress') as String;
  }

  Future<void> initHive() async {
    if (hasInitPrefs) {
      return;
    }
    // await Hive.initFlutter();
    box = await Hive.openBox('data');
    hasInitPrefs = true;
  }

  Future<List<String>> getAllCountries() async {
    final List<QueryDocumentSnapshot> countriesSnapshot =
        (await db.collection('masjid').get()).docs;

    final List<String> countryNames = <String>[];

    countriesSnapshot.forEach((QueryDocumentSnapshot country) {
      print(country.id);
      countryNames.add(country.id);
    });

    return countryNames;
  }

  Future<List<String>> getAllCities(String country) async {
    final List<QueryDocumentSnapshot> citiesSnapshot =
        (await db.collection('masjid').doc(country).collection('cities').get())
            .docs;

    final List<String> cityNames = <String>[];

    citiesSnapshot.forEach((QueryDocumentSnapshot city) {
      print(city.id);
      cityNames.add(city.id);
    });

    return cityNames;
  }

  Future<List<Map<String, dynamic>>> getAllMasjids(
      String country, String city) async {
    print('Country: $country');
    print('City: $city');
    final List<QueryDocumentSnapshot> masjidSnapshot = (await db
            .collection('masjid')
            .doc(country)
            .collection('cities')
            .doc(city)
            .collection('masjids')
            .get())
        .docs;

    print('Result:::');
    print(masjidSnapshot);

    final List<String> masjidNames = <String>[];
    final List<Map<String, dynamic>> masjids = <Map<String, dynamic>>[];

    masjidSnapshot.forEach((QueryDocumentSnapshot masjid) {
      print(masjid.id);
      masjidNames.add(masjid.id);
      masjids.add(masjid.data());
    });

    return masjids;
  }

  // int readInt(String key) {
  //   return prefs.getInt(key);
  // }

  // Future<bool> writeInt(String key, int value) async {
  //   if (value == null) {
  //     return true;
  //   }
  //   return prefs.setInt(key, value);
  // }

  // Future<bool> writeDouble(String key, double value) async {
  //   if (value == null) {
  //     return true;
  //   }
  //   return prefs.setDouble(key, value);
  // }

  // double readDouble(String key) {
  //   return prefs.getDouble(key);
  // }

  // String readString(String key) {
  //   return prefs.getString(key);
  // }

  // void writeString(String key, String value) {
  //   if (value == null) {
  //     return;
  //   }
  //   // return prefs.setString(key, value);
  //   box.put(key, value);
  // }

  void write(String key, dynamic value) {
    box.put(key, value);
  }

  dynamic read(String key) {
    return box.get(key);
  }
}
