import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/main_bloc.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({Key key}) : super(key: key);

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  bool isLoading = true;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    final MainBloc mainBloc = Provider.of<MainBloc>(context, listen: false);
    mainBloc.initHive().then((_) {
      print('Value:');
      print(mainBloc.read('hasSelectedMasjid'));
      if (mainBloc.read('hasSelectedMasjid') != null &&
          mainBloc.read('hasSelectedMasjid') == true) {
        mainBloc.getAllData();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (_) => false,
        );
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height - statusBarHeight;
    final double width = MediaQuery.of(context).size.width;
    final MainBloc mainBloc = Provider.of<MainBloc>(context);

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: SpinKitWave(
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        width: width,
        height: height,
        color: const Color(0xFF303030),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            const Text(
              'WELCOME',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Select your masjid, if it is registered',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 0.76 * height,
              width: width,
              child: SingleChildScrollView(
                child: FutureBuilder<List<String>>(
                  future: mainBloc.getAllCountries(),
                  builder:
                      (BuildContext ctx, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.hasData) {
                      final List<String> countries = snapshot.data;
                      final List<Widget> renderData = <Widget>[];

                      countries.forEach((String country) {
                        print('Country: $country');
                        renderData.add(
                          SizedBox(
                            width: 0.9 * width,
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: const Color(0xFF424242),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/cities',
                                  arguments: country,
                                );
                              },
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: country,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    country,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                        renderData.add(
                          const SizedBox(
                            height: 20,
                          ),
                        );
                      });
                      return Column(
                        children: <Widget>[
                          ...renderData,
                          // ...renderData,
                          // ...renderData,
                        ],
                      );
                    } else {
                      return const SpinKitWave(
                        // size: ,
                        color: Colors.white,
                        // type: SpinKitWaveType.,
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              width: 0.96 * width,
              child: Divider(
                height: 2,
                color: Colors.grey.withOpacity(0.5),
                thickness: 2,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Didn't find your country on the list?",
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                const SizedBox(
                  width: 10,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: const Color(0xFF424242),
                  onPressed: () {},
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
