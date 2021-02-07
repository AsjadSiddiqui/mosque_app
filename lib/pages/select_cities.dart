import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/main_bloc.dart';

class WelcomeCities extends StatefulWidget {
  const WelcomeCities({Key key}) : super(key: key);

  @override
  _WelcomeCitiesState createState() => _WelcomeCitiesState();
}

class _WelcomeCitiesState extends State<WelcomeCities> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height -
        statusBarHeight -
        AppBar().preferredSize.height;
    final double width = MediaQuery.of(context).size.width;
    final MainBloc mainBloc = Provider.of<MainBloc>(context);

    final Object country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        title: const Text(
          'Select City',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        width: width,
        height: height,
        color: const Color(0xFF303030),
        child: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 35,
            // ),
            Hero(
              transitionOnUserGestures: true,
              tag: country,
              child: Material(
                child: Text(
                  country as String,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            // Text(
            //   'WELCOME',
            //   style: GoogleFonts.openSans(
            //     fontSize: 20,
            //     fontWeight: FontWeight.w300,
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'Select City',
            //   style: GoogleFonts.montserrat(
            //     fontWeight: FontWeight.w300,
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 0.76 * height,
              width: width,
              child: SingleChildScrollView(
                child: FutureBuilder<List<String>>(
                  future: mainBloc.getAllCities(country as String),
                  builder:
                      (BuildContext ctx, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.hasData) {
                      final List<String> cities = snapshot.data;
                      final List<Widget> renderData = <Widget>[];

                      cities.forEach((String city) {
                        // ignore: avoid_print
                        print('City: $city');
                        renderData.add(
                          SizedBox(
                            width: 0.9 * width,
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: const Color(0xFF424242),
                              onPressed: () {
                                print('Pressed $city!');
                                Navigator.of(context).pushNamed(
                                  '/masjids',
                                  arguments: <String, dynamic>{
                                    'city': city,
                                    'country': country,
                                  },
                                );
                              },
                              child: Text(
                                city,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
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
                        children: renderData,
                      );
                    } else {
                      return SizedBox(
                        width: width,
                        height: 0.7 * height,
                        child: const Center(
                          child: SpinKitWave(
                            // size: ,
                            color: Colors.white,
                            // type: SpinKitWaveType.,
                          ),
                        ),
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
                  "Didn't find your city on the list?",
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
