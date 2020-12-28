import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../blocs/mainBloc.dart';

class WelcomeCities extends StatefulWidget {
  WelcomeCities({Key key}) : super(key: key);

  @override
  _WelcomeCitiesState createState() => _WelcomeCitiesState();
}

class _WelcomeCitiesState extends State<WelcomeCities> {
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
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Select City',
              style: GoogleFonts.montserrat(
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
                  future: mainBloc.getAllCities('PAKISTAN'),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      final cities = (snapshot.data as List<String>);
                      List<Widget> renderData = [];

                      cities.forEach((city) {
                        print('City: $city');
                        renderData.add(
                          Container(
                            width: 0.9 * width,
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: Color(0xFF424242),
                              onPressed: () {},
                              child: Text(
                                city,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
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
                        children: renderData,
                      );
                    } else {
                      return CircularProgressIndicator();
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
                Text('Didn\'t find your city on the list?'),
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
                    style: GoogleFonts.montserrat(),
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
