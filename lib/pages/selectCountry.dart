import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/mainBloc.dart';

class SelectCountry extends StatefulWidget {
  SelectCountry({Key key}) : super(key: key);

  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final height = MediaQuery.of(context).size.height - statusBarHeight;
    final width = MediaQuery.of(context).size.width;
    final mainBloc = Provider.of<MainBloc>(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        width: width,
        height: height,
        color: Color(0xFF303030),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Text(
              'WELCOME',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Select your masjid, if it is registered',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 0.76 * height,
              width: width,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: mainBloc.getAllCountries(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      final countries = (snapshot.data as List<String>);
                      List<Widget> renderData = [];

                      countries.forEach((country) {
                        print('Country: $country');
                        renderData.add(
                          Container(
                            width: 0.9 * width,
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Color(0xFF424242),
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
                                    style: TextStyle(
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
                          SizedBox(
                            height: 20,
                          ),
                        );
                      });
                      return Column(
                        children: [
                          ...renderData,
                          // ...renderData,
                          // ...renderData,
                        ],
                      );
                    } else {
                      return SpinKitWave(
                        // size: ,
                        color: Colors.white,
                        // type: SpinKitWaveType.,
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
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
              children: [
                Text(
                  'Didn\'t find your country on the list?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Color(0xFF424242),
                  onPressed: () {},
                  child: Text(
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
