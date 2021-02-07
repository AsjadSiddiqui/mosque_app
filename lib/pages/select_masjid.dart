import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../blocs/main_bloc.dart';

class SelectMasjid extends StatefulWidget {
  const SelectMasjid({Key key}) : super(key: key);

  @override
  _SelectMasjidState createState() => _SelectMasjidState();
}

class _SelectMasjidState extends State<SelectMasjid> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double height = MediaQuery.of(context).size.height -
        statusBarHeight -
        AppBar().preferredSize.height;
    final double width = MediaQuery.of(context).size.width;
    final MainBloc mainBloc = Provider.of<MainBloc>(context);

    final Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String city = args['city'] as String;
    final String country = args['country'] as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        title: const Text(
          'Select Masjid',
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
              tag: city,
              child: Material(
                child: Text(
                  city as String,
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: mainBloc.getAllMasjids(country, city),
                  builder: (BuildContext ctx,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      final List<Map<String, dynamic>> masjids = snapshot.data;
                      final List<Widget> renderData = <Widget>[];

                      masjids.forEach((Map<String, dynamic> masjid) {
                        // ignore: avoid_print
                        print('Masjid: ${masjid['masjid']}');
                        renderData.add(
                          SizedBox(
                            width: 0.9 * width,
                            // height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color: const Color(0xFF424242),
                              onPressed: () {
                                print('Pressed ${masjid['masjid']}!');
                                print('Saving Data !');
                                mainBloc.write('country', country);
                                mainBloc.write('city', city);
                                // mainBloc.write('masjid', masjid);
                                mainBloc.write('masjid', masjid['masjid']);
                                mainBloc.write(
                                    'nameArabic', masjid['nameArabic']);
                                mainBloc.write(
                                    'masjidImageURL', masjid['imageURL']);
                                mainBloc.write(
                                    'masjidAddress', masjid['address']);
                                mainBloc.write('hasSelectedMasjid', true);

                                mainBloc.city = city;
                                mainBloc.country = country;
                                mainBloc.masjidName =
                                    masjid['masjid'] as String;
                                mainBloc.masjidImageURL =
                                    masjid['imageURL'] as String;
                                mainBloc.masjidAddress =
                                    masjid['address'] as String;
                                mainBloc.masjidNameArabic =
                                    masjid['nameArabic'] as String;

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home',
                                  (_) => false,
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(0.065 * height),
                                      child: Image.network(
                                        masjid['imageURL'] as String,
                                        width: 0.065 * height,
                                        height: 0.065 * height,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          masjid['masjid'] as String,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: (0.9 * width) -
                                              (0.065 * height) -
                                              50,
                                          child: Text(
                                            masjid['address'] as String,
                                            textAlign: TextAlign.left,
                                            // maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
